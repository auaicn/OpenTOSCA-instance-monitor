from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import status
from .topology import get_topology
from .fetch_ids import get_csar_instances_containers_id
from .fetch_id import services
import requests
import json 

def topology(request, service_tmp):
    base_url = "http://localhost:8080/winery/servicetemplates/"
    service_templates = requests.get(base_url)
    sts = service_templates.json()

    select = None
    for s in sts:
        if s['id'] == service_tmp:
            select = s
            break
    
    if select is not None:
        namespace = select['namespace'].replace(':', '%253A')
        namespace = namespace.replace('/', '%252F')
        url = base_url + namespace + '/' + service_tmp + '/xml'
        ret = get_topology(url)

        return HttpResponse(ret, status = status.HTTP_200_OK)
    else:
        return HttpResponse("wrong input", status = status.HTTP_400_BAD_REQUEST)

def instance(request, service_tmp):
    csar_instance, instance_container =get_csar_instances_containers_id() 
    service_name = service_tmp + '.csar'
    if service_name in csar_instance:
        return HttpResponse(json.dumps(csar_instance[service_name]), status = status.HTTP_200_OK)
    else:
        return HttpResponse("wrong input", status = status.HTTP_400_BAD_REQUEST)

def container_id(request, service_tmp, instance_id):
    csar_instance, instance_container =get_csar_instances_containers_id() 
    if instance_id in instance_container:
        ret = instance_container[instance_id]
        return HttpResponse(json.dumps(ret), status = status.HTTP_200_OK)
    else:
        return HttpResponse("wrong input", status = status.HTTP_400_BAD_REQUEST)

def service_template(request):
    return HttpResponse(json.dumps(services()), status = status.HTTP_200_OK)

def total(request, service_tmp):
    ret = {}
    csar_instance, instance_container = get_csar_instances_containers_id()
    name = service_tmp + '.csar'
    if name in csar_instance:
        for i in csar_instance[name]:
            ret[i] = instance_container[i]
        return HttpResponse(json.dumps(ret), status = status.HTTP_200_OK)
    else:
        return HttpResponse("wrong input", status = status.HTTP_400_BAD_REQUEST)  