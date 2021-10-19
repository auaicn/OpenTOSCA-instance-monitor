from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('<str:service_tmp>', views.total),
    path('<str:service_tmp>/topology', views.topology),
    path('<str:service_tmp>/instances', views.instance),
    path('<str:service_tmp>/instances/<int:instance_id>', views.container_id),
    path('', views.service_template),    
]