from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response

class Pagepagination(PageNumberPagination):
    page_size = 20
    page_size_query_param = "page size"
    max_page_size = 40
    
    def get_paginated_response(self, data):
        """
        Custom pagination with neccesary urls
        """
        return Response({
            "total-items" : self.page.paginator.count,
            "total-pages" : self.page.paginator.num_pages,
            "current-page" : self.page.number,
            "next-page" : self.get_next_link(),
            "previous-page" : self.get_previous_link(),
            "number of items" : len(self.page),
            "data" : data
        })