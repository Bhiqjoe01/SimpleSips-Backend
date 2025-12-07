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
        
        
class OrderSerializer(serializers.ModelSerializer):
    """
    Serializer for the Order model.

    - Automatically includes all essential order fields.
    - `user`, `reference_id`, and `order_id` should be read-only.
    - The user is attached from the request, not from the frontend.
    - Used for both creating and retrieving orders.
    """

    class Meta:
        model = Order
        fields = "__all__"
        read_only_fields = ['reference_id', 'user', 'total_amount', 'status', 'order_id', 'created_at', 'updated_at']
        
class OrderitemSerializer(serializers.ModelSerializer):
    """
    Serializer for the OrderItem model.

    - Automatically includes all essential order item fields.
    - `price`, `sub_total`, and `cart_item` should be read-only.
    - Used for both creating and retrieving order items.
    """

    class Meta:
        model = OrderItem
        fields = "__all__"
        read_only_fields = ['price', 'sub_total', 'cart_item', 'order']

    def validate(self, attrs):
        item = attrs.get('item')
        quantity = attrs.get('quantity')

        if item and quantity:
            with transaction.atomic():
                locked_item = Item.objects.select_for_update().get(pk=item.pk)
                if locked_item and locked_item.stock < quantity:
                    raise serializers.ValidationError(f"only {locked_item.stock} items are available in stock")

        return attrs

    def create(self, validated_data):
        order = self.context.get('order')

        if order.status != 'PENDING':
            raise serializers.ValidationError("Cannot modify items of an order that is not pending.")
        item = validated_data.get('item')
        quantity = validated_data.get('quantity', 1)
        existing_order_item = order.order_items.filter(item=item).first()
        if existing_order_item:
            existing_order_item.quantity += quantity
            existing_order_item.save()
            return existing_order_item
        return OrderItem.objects.create(order=order, **validated_data)

    def update(self, instance, validated_data):
        order = instance.order

        if order.status != 'PENDING':
            raise serializers.ValidationError("Cannot modify items of an order that is not pending.")

        item = instance.item
        new_quantity = validated_data.get('quantity', instance.quantity)
        diff_quantity = new_quantity - instance.quantity
        
        if diff_quantity == 0:
            return instance
        return super().update(instance, validated_data)
        