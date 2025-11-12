from django.shortcuts import render
from rest_framework import generics
from django.contrib.auth.models import User
from .serializers import UserSerializer, RegisterSerializer
from rest_framework.permissions import IsAuthenticated
# Create your views here.


class RegisterView(generics.CreateAPIView):
    """
    POST endpoint to register a new user.

    This view allows clients to create new user accounts by providing:
     username
     email
     first_name
     last_name
     password

    The password is write-only and will not appear in responses.
    Password is validated according to security rules defined in the serializer.
    """
    queryset = User.objects.all()
    serializer_class = RegisterSerializer


class profileView(generics.RetrieveAPIView):
    """
    GET endpoint to retrieve the authenticated user's profile.

    Uses UserSerializer to serialize user data.
    Requires authentication; returns information of the currently logged-in user.
    """
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        return self.request.user
    