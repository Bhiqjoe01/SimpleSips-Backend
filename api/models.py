from django.db import models
from django.utils.text import slugify
from django.contrib.auth.models import User
import uuid
import datetime

# Create your models here.
class Category(models.Model):
    name = models.CharField(max_length=30)
    
    def __str__(self):
        return self.name

class Item(models.Model):
    name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True, null=True, blank=True)
    image = models.ImageField(upload_to ='item/', default = 'dafault.png.jpeg' )
    description = models.TextField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, related_name='item')
    stock = models.PositiveIntegerField(default=0)
    count = models.PositiveIntegerField(default=0)
    ctreated_at = models.DateTimeField(auto_now_add=True)
    isavailable = models.BooleanField(default=True)
    
    
    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)
        

    def __str__(self):
        return self.name
    
class Cart (models.Model):
    cartItem = models.ForeignKey(Item, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    added_at = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"{self.quantity} of {self.cartItem} for {self.user.username}"
    
class Order (models.Model):
    """
    Represents a customer's order.
    An order is linked to a user and contains multiple order items.
    
    """
    STATUS_CHOICES = [
        ('PENDING', 'Pending'),
        ('PROCESSING', 'Processing'),
        ('COMPLETED', 'Completed'),
        ('CANCELLED', 'Cancelled'),
    ]
    reference_id = models.UUIDField(default=uuid.uuid4, editable=False, unique=True, primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='orders')
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    status = models.CharField(max_length= 20, choices=STATUS_CHOICES, default='PENDING')
    order_id = models.CharField(max_length=20, unique=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def save(self, *args, **kwargs):
        if not self.order_id:
            now = datetime.datetime.now()
            year = now.strftime("%y")
            month = now.strftime("%m")
            day = now.strftime("%d")
            count = Order.objects.filter(created_at__year=now.year, created_at__month=now.month).count() + 1 
            self.order_id = f"@SIMP-ORD-{year}{month}{day}-{count:04d}"
            print(self.order_id)
            
    
        super().save(*args, **kwargs)
    
    
    def __str__(self):
        return f"Order {self.order_id} by {self.user.username}"
    
class OrderItem (models.Model):
    """
    Represents an item within a customer's order.
    Each order item is linked to a specific order and item, and includes quantity and pricing details
    """
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='order_items')
    item = models.ForeignKey(Item, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    sub_total = models.DecimalField(max_digits=10, decimal_places=2, editable=False)
    cart_item = models.ForeignKey(Cart, on_delete=models.SET_NULL, null=True, blank=True)
    
    def save(self, *args, **kwargs):
        
        is_new = self.pk is None
        if is_new:
            self.price = self.item.price
            if self.item.stock < self.quantity:
                raise ValueError(f"only {self.item.stock} items are available in stock")
            self.item.stock -= self.quantity
            self.item.save(update_fields=['stock'])
        
        self.sub_total = self.quantity * self.price
        super().save(*args, **kwargs)
        self.order.total_amount = sum(self.order.order_items for x in self.order.order_items.all())
        self.order.save(update_fields=['total_amount'])
    
    
    
    def delete(self, *args, **kwargs):
        
        if self.order.status != 'PENDING':
            raise ValueError("Cannot delete items from an order that is not pending.")
        self.item.stock += self.quantity
        self.item.save(update_fields=['stock'])
        super().delete(*args, **kwargs)
        
        self.order.total_amount = sum(x.sub_total for x in self.order.order_items.all())
        self.order.save(update_fields=['total_amount'])
    def __str__(self):
        return f"{self.quantity} of {self.item.name} in order {self.order.reference_id} by {self.order.user.username}"    