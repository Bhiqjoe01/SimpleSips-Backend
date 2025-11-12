from django.shortcuts import render
from rest_framework import viewsets, filters, permissions, status
from .models import Item, Category, Cart
from .serializers import ItemSerializer, CategorySerializer, CartSerializer
from rest_framework import generics
from rest_framework.response import Response 
from .pagination import Pagepagination
from django.db.models import Q



# Create your views here.
class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Provides read-only access to product categories.
    Only GET requests are allowed.
    Clients can retrieve a list of categories or a single category by ID.
    """
    queryset = Category.objects.all().order_by("name")
    serializer_class = CategorySerializer

class FeauturedItem(generics.ListAPIView):
    """
    API view to retrieve the details items.
    """
    queryset = Item.objects.filter(isavailable = True).order_by('-count')[:10]
    serializer_class = ItemSerializer
    
    def list(self, rquest, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
        
        


class ItemViewSet(viewsets.ModelViewSet):
    """
    Handles all item operations with search, filtering, and pagination.
    - Clients can retrieve, search, or filter items by category or name.
    - Items marked as unavailable are automatically excluded.
    - DELETE requests are blocked for safety (read-only deletion policy).
    """


    queryset = Item.objects.filter(isavailable = True).order_by('-count')
    serializer_class = ItemSerializer
    pagination_class = Pagepagination
    filter_backends = [filters.SearchFilter]
    search_fields = ["category__name", "name"]
    
    def get_queryset(self):
        queryset = Item.objects.filter(isavailable = True). order_by("-count")
        search_query = self.request.query_params.get("search", None)
        category_query = self.request.query_params.get("category", None)
        
        if search_query:
            queryset = queryset.filter(
                Q(name__icontains=search_query) |
                Q(category__name__icontains=search_query)
            )
        if category_query:
            queryset = queryset.filter(category__name__iexact=category_query)
            
        return queryset
    
    
    def destroy(self, request, *args, **kwargs):
        return Response(
            {"detail": "Delete method is not allowed."},
            status=status.HTTP_405_METHOD_NOT_ALLOWED
        )
    
class singleFeaturedItem(generics.RetrieveAPIView):
    """
    Retrieves a single item by its slug and increments its view count.
    - Tracks popularity by increasing the 'count' field on every GET request.
    - Only GET is allowed.
    """
    serializer_class = ItemSerializer
    queryset = Item.objects.filter(isavailable= True)
    fields = ['id', 'name',  'image', 'price', 'discription','category', 'stock', 'count', 'ctreated_at', 'isavailable']
    lookup_field = 'slug'
    
    def retrieve(self, request, *args, **kwargs):
        Item = self.get_object ()
        Item.count += 1
        Item.save(update_fields= ['count'])
        
        serializer = self.get_serializer(Item)
        
        return Response(serializer.data)
class CartViewSet(viewsets.ModelViewSet):
    """
    Manages the authenticated user's shopping cart.
    - Users can add, update, or remove items in their cart.
    - Quantity changes and stock validations are handled automatically.
    - Only authenticated users can access this endpoint.
    """
    serializer_class = CartSerializer
    permission_classes = [permissions.IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        return Cart.objects.filter(user=user).select_related('cartItem').order_by('-added_at')
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    
    def update(self, request, *args, **kwargs):
        """Handle add, subtract, remove actions through PATCH/PUT"""
        instance = self.get_object()
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        updated_cart = serializer.save()
        if updated_cart is None:  
            return Response({"detail": "Item removed from cart."}, status=status.HTTP_204_NO_CONTENT)
        return Response(CartSerializer(updated_cart).data, status=status.HTTP_200_OK)