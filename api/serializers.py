from rest_framework import serializers
from .models import Item, Category, Cart, Order, OrderItem
from django.db.models import Sum
from django.db import transaction


class ItemSerializer(serializers.ModelSerializer):
    """
    Serializer for the Item model.
    this serializer includes the following fields:
    id
    name
    image
    price
    category
    stock
    count
    ctreated_at
    isavailable
    """
    class Meta:
        model = Item
        fields = ['id', 'name', 'image', 'price', 'category', 'stock', 'count', 'ctreated_at', 'isavailable']
        
class CategorySerializer (serializers.ModelSerializer):
   """
   Serializer for the Category model.
   This serializer includes the fields:
   id
   name
   """

   class Meta:
        model = Category
        fields = ['id', 'name']
class CartSerializer (serializers.ModelSerializer):
    """
    Serializer for the Cart model.
    This serializer includes the fields:
    id
    cartItem
    itemName
    itemPrice
    quantity
    itemImage
    sub_total
    It also includes validation to ensure that the quantity is at least 1 and
    checks stock availability.
    The create and update methods handle adding items to the cart and updating
    quantities while ensuring stock consistency.
    """
    cartItem = serializers.PrimaryKeyRelatedField(queryset=Item.objects.all())
    itemName = serializers.ReadOnlyField(source='cartItem.name')
    itemPrice = serializers.ReadOnlyField(source='cartItem.price')
    itemImage = serializers.SerializerMethodField()
    sub_total = serializers.SerializerMethodField()
    
    def get_itemImage(self, obj):
         request = self.context.get('request')
         if obj.cartItem.image and request:
                return request.build_absolute_uri(obj.cartItem.image.url)
         return None
    
    def get_sub_total(self, obj):
        return obj.cartItem.price * obj.quantity
    
    class Meta:
        model = Cart
        fields = ['id', 'cartItem', 'itemName', 'itemPrice', 'quantity', 'itemImage', 'sub_total',]
        
        
    def validate_quantity(self, value):
        if value < 1:
            raise serializers.ValidationError("Quantity must not be less tan 1")
        return value
    
    def validate(self, data):
        """
        validation to check stock availability
        requested quantity should not be more than available stock
        also handles update case
        """
        
        request = self.context.get('request')
        if request is None or not getattr(request, 'user', None) or not request.user.is_authenticated:
            raise serializers.ValidationError("Sorry only Registered users can add items to cart")
        
        data['user'] = request.user
        
        item = data.get('cartItem', None) or getattr(self.instance, 'cartItem', None)
        if item is None:
            raise serializers.ValidationError({"cartItem": "This field is required."})
        requested_quantity = data.get('quantity', None) or getattr(self.instance, 'quantity', None)
        if requested_quantity < 1:
            raise serializers.ValidationError("Quantity must be at least 1")
        
        if item.stock < requested_quantity:
            raise serializers.ValidationError(f"Only {item.stock} is left in the store reduce your quantity")
        
        user = request.user
        if user.is_authenticated:
            qs = Cart.objects.filter(user=user, cartItem=item)
        if self.instance:
            qs = qs.exclude(pk=self.instance.pk)
        
        agg = qs.aggregate(total=Sum('quantity'))
        existing_cart_item = agg.get('total') or 0

        all_total = existing_cart_item + requested_quantity

        if all_total > item.stock:
            raise serializers.ValidationError(
                f"Only {item.stock} of '{item.name}' left in the store. Reduce your quantity."
            )

        data['quantity'] = requested_quantity

                
        return data
                
    def create(self, validated_data):
        user = validated_data['user']
        item = validated_data['cartItem']
        quantity = validated_data.get('quantity', 1)
        
        locked = 4  

        with transaction.atomic():
            item = Item.objects.get(pk=item.pk)

            if item.stock <= locked:
                item = Item.objects.select_for_update().get(pk=item.pk)

            existing_cart_item = Cart.objects.filter(user=user, cartItem=item).first()

            if existing_cart_item:
                if item.stock <= locked:
                    existing_cart_item = Cart.objects.select_for_update().get(pk=existing_cart_item.pk)

                new_quantity = existing_cart_item.quantity + quantity

                if new_quantity > item.stock:
                    raise serializers.ValidationError(
                        f"Only {item.stock} of '{item.name}' left in the store. Reduce your quantity."
                    )

                existing_cart_item.quantity = new_quantity
                existing_cart_item.save()
                return existing_cart_item

            if quantity > item.stock:
                raise serializers.ValidationError(
                    f"Only {item.stock} of '{item.name}' left in the store. Reduce your quantity."
                )

            return Cart.objects.create(user=user, cartItem=item, quantity=quantity)
        
    def update(self, instance, validated_data):    
        request = self.context.get('request')
        action = str(request.data.get('action', "")).lower()
        if action not in ['add', 'subtract', 'remove']:
            raise serializers.ValidationError('Invalid action. Must be one of: add, subtract, remove.')    
        locked = 4
        
        with transaction.atomic():
            item = Item.objects.get(pk= instance.cartItem.pk)
            
            if item.stock <= locked:
                item = Item.objects.select_for_update().get(pk=item.pk)
                
            cart_row = Cart.objects.select_for_update().get(pk = instance.pk)
            
            if action == 'add':
                new_quantity = cart_row.quantity + 1
            elif action == 'subtract':
                new_quantity = max(cart_row.quantity -1, 1 )
            elif action == 'remove':
                cart_row.delete()
                self.context['removed'] = True
                return None
            
            if new_quantity > item.stock:
                raise serializers.ValidationError(
                    f"Only {item.stock} of '{item.name}' left in the store. Reduce your quantity."
                )
                
            cart_row.quantity = new_quantity
            cart_row.save()
            return cart_row
        
        
class orderSerializer(serializers.ModelSerializer):
    """
    Serializer for the Order model.
    This serializer includes the fields:
    reference_id
    user
    total_amount
    status
    order_id
    created_at
    updated_at
    """
    class Meta:
        model = Order
        fields = ['reference_id', 'user', 'total_amount', 'status', 'order_id', 'created_at', 'updated_at']
        
        
        

                
    
  
    
  
        
    
    
    
    
    
    
    
    
    
#     from decimal import Decimal

# from django.db import transaction
# from django.db.models import F
# from rest_framework import serializers
# from .models import Cart, Item

# class CartSerializer(serializers.ModelSerializer):
#     # Extra read-only fields to make API responses friendlier
#     cartItem_name = serializers.ReadOnlyField(source='cartItem.name')
#     item_price = serializers.ReadOnlyField(source='cartItem.price')
#     total_price = serializers.SerializerMethodField()

#     class Meta:
#         model = Cart
#         # Expose relevant fields; user & added_at are read-only (set by view/DB)
#         fields = [
#             'id', 'cartItem', 'cartItem_name', 'item_price',
#             'quantity', 'total_price', 'user', 'added_at',
#         ]
#         read_only_fields = ['id', 'user', 'added_at', 'cartItem_name', 'item_price', 'total_price']

#     def get_total_price(self, obj):
#         """Return decimal total price for this cart line (quantity * unit price)."""
#         # Ensure Decimal arithmetic
#         return (Decimal(obj.quantity) * Decimal(obj.cartItem.price)).quantize(Decimal('0.01'))

#     def validate_quantity(self, value):
#         """Field-level validation for quantity (must be >= 1)."""
#         if value < 1:
#             raise serializers.ValidationError("Quantity must be at least 1.")
#         return value

#     def validate(self, data):
#         """
#         Object-level validation used on create.
#         - Ensures the item exists (DRF does this) and stock is enough for the requested quantity
#         """
#         # If object-level call during update, 'quantity' may not be in data.
#         quantity = data.get('quantity', None)
#         item = data.get('cartItem', None)

#         # If serializer is being used to update partial data, skip detailed stock check here;
#         # update() will handle locking/stock checks because we need the existing instance.
#         if self.instance is not None:
#             return data

#         if item is None:
#             raise serializers.ValidationError({"cartItem": "This field is required."})

#         if quantity is None:
#             quantity = 1

#         if item.stock < quantity:
#             raise serializers.ValidationError(f"Only {item.stock} left in stock for '{item.name}'.")

#         return data

#     def create(self, validated_data):
#         """
#         Add an item to the user's cart. If a cart line already exists for this user+item,
#         increase its quantity. All stock modifications happen inside an atomic transaction
#         and we use select_for_update() to lock the item row (prevents race conditions).
#         """
#         request = self.context.get('request')
#         if request is None or not hasattr(request, 'user'):
#             raise serializers.ValidationError("Request user is required.")

#         user = request.user
#         item = validated_data['cartItem']
#         add_quantity = validated_data.get('quantity', 1)

#         with transaction.atomic():
#             # Lock the item row so concurrent requests update stock safely
#             locked_item = Item.objects.select_for_update().get(pk=item.pk)

#             if locked_item.stock < add_quantity:
#                 raise serializers.ValidationError(f"Only {locked_item.stock} left in stock for '{locked_item.name}'.")

#             # Try to fetch existing cart line
#             cart_line, created = Cart.objects.select_for_update().get_or_create(
#                 user=user,
#                 cartItem=locked_item,
#                 defaults={'quantity': add_quantity}
#             )

#             if not created:
#                 # If it already exists, add the new quantity
#                 new_quantity = cart_line.quantity + add_quantity

#                 # No need to check total against some original stock here because locked_item.stock
#                 # already reflects remaining stock after previous reservations.
#                 if locked_item.stock < add_quantity:
#                     raise serializers.ValidationError(f"Cannot add {add_quantity} more. Only {locked_item.stock} left in stock.")

#                 cart_line.quantity = new_quantity
#                 cart_line.save()
#             else:
#                 cart_line.save()

#             # Deduct only the added quantity from stock (existing reserved qty already deducted earlier)
#             locked_item.stock = F('stock') - add_quantity
#             locked_item.save()

#         # Refresh from DB to get actual numeric value if F() was used
#         cart_line.refresh_from_db()
#         return cart_line

#     def update(self, instance, validated_data):
#         """
#         Update a cart line's quantity. This must:
#         - Lock the related Item row
#         - Compute the difference between new and old quantity
#         - If increasing, ensure enough stock and deduct the difference
#         - If decreasing, return the difference back to stock
#         """
#         new_quantity = validated_data.get('quantity', instance.quantity)

#         if new_quantity < 1:
#             raise serializers.ValidationError("Quantity must be at least 1. To remove an item, use DELETE on the cart line.")

#         with transaction.atomic():
#             # Lock item row for safe stock update
#             locked_item = Item.objects.select_for_update().get(pk=instance.cartItem.pk)

#             diff = new_quantity - instance.quantity  # positive -> need more stock; negative -> release stock

#             if diff > 0:
#                 # Need more units
#                 if locked_item.stock < diff:
#                     raise serializers.ValidationError(f"Only {locked_item.stock} left in stock for '{locked_item.name}'. Cannot increase by {diff}.")
#                 # Deduct extra units
#                 locked_item.stock = F('stock') - diff
#                 locked_item.save()
#             elif diff < 0:
#                 # User decreased quantity — release stock back
#                 locked_item.stock = F('stock') + abs(diff)
#                 locked_item.save()

#             # Apply new quantity to cart line
#             instance.quantity = new_quantity
#             instance.save()

#         instance.refresh_from_db()
#         return instance