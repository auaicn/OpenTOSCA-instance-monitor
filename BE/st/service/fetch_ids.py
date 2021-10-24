from .fetch import ids
from .hostname import base_url
import re
import json
import subprocess
import xmltodict
import requests
import os

url = "http://" + base_url + ":2220/v1.19/containers/opentosca_engine-ia_1/logs?stderr=1"

def read_container_log():
    response = requests.get(url)
    
    if response.status_code != 200:
        print("container log api error....")
        exit()

    log = response.text
    return log

def log_parsing():    
    log = read_container_log()
    
    return re.split('----------------------------', log)

def get_csar_instances_containers_id():
    csar_instance_dict, instance_container_dict = ids()
    logs = log_parsing()
    for l in logs:
        if "NODETEMPLATEID_STRING" in l and "SERVICEINSTANCEID_URI" in l:
            if "ContainerID" in l:
                print(l)
                x = re.split(r': ', l)
                xml_string = x[-1]
                
                service_instance_uri = re.findall(r"<SERVICEINSTANCEID_URI>(.+?)</SERVICEINSTANCEID_URI>", xml_string)[0]
                service_instance = int(service_instance_uri.split('/')[-1])
                
                node_template = re.findall(r"<NODETEMPLATEID_STRING>(.+?)</NODETEMPLATEID_STRING>", xml_string)[0]
                container_id = re.findall(r"<ContainerID>(.+?)</ContainerID>", xml_string)[0]
                
                if node_template not in instance_container_dict[service_instance]:
                    instance_container_dict[service_instance][node_template] = container_id

    for instance in instance_container_dict:
        tmp = instance_container_dict[instance]
        instance_container_dict[instance] = [{
            "topologyLabel": key,
            "containerId": tmp[key]
        } for key in tmp]

    return csar_instance_dict, instance_container_dict            
