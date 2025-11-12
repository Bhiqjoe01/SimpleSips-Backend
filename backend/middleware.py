from django.http import JsonResponse
from django.conf import settings


class APImiddleware:
    def __init__(self, get_response):
        self.get_response = get_response
        
    def __call__(self, request):
        if request.path.startswith('/api/auth/'):
            key = request.headers.get('X-API-KEY')
            if key != getattr(settings, 'MY_API_KEY', None):
                return JsonResponse({'error': 'You must have a valid pass key from Big Joe!'}, status=403)
        
        return self.get_response(request)
                
           