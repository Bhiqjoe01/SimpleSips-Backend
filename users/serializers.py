from rest_framework import serializers
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):
    
    """
    Serializer for the User model.

    Includes fields: id, username, email, first_name, last_name.
    first_name, last_name, and email are required fields.
    Used for retrieving user profile information in API responses.
    """
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
        extra_kwargs = {
            'first_name': {'required': True},
            'last_name': {'required': True},
            'email': {'required': True},
        }


class RegisterSerializer(serializers.ModelSerializer):
    
    """
     Serializer for registering a new user.

     Fields: username, email, first_name, last_name, and password.
     The password field is write-only to prevent exposure in API responses.
     Includes custom password validation to enforce security requirements:
      Minimum length of 8 characters
      At least one digit
      At least one alphabet character
      At least one uppercase letter
      Must not contain the username
    """
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password', 'first_name', 'last_name']
        extra_kwargs = {
            'password': {'write_only': True, 'required': True},
            'email': {'required': True},
        }

    def validate_password(self, value):
        username = self.initial_data.get('username')

        if len(value) < 8:
            raise serializers.ValidationError("Password must be at least 8 characters long.")
        if not any(char.isdigit() for char in value):
            raise serializers.ValidationError("Password must contain at least one digit.")
        if not any(char.isalpha() for char in value):
            raise serializers.ValidationError("Password must contain at least one alphabet.")
        if not any(char.isupper() for char in value):
            raise serializers.ValidationError("Password must contain at least one uppercase letter.")
        if username and username.lower() in value.lower():
            raise serializers.ValidationError("Password must not contain the username.")

        return value

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            password=validated_data['password']
        )
        return user
