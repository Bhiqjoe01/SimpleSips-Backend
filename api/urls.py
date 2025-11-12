from rest_framework.routers import DefaultRouter
from .views import ItemViewSet, FeauturedItem, singleFeaturedItem, CategoryViewSet, CartViewSet
from django.urls import path
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
)

router = DefaultRouter()
router.register(r'items', ItemViewSet),
router.register(r'categories', CategoryViewSet)
router.register(r'cart', CartViewSet, basename='cart')

urlpatterns = [
    path('items/feautured/', FeauturedItem.as_view(), name='feautured-product'),
    path('items/<slug:slug>/', singleFeaturedItem.as_view(), name='single-feautured-product'),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]


urlpatterns += router.urls