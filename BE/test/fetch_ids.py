from fetch_id import ids
import re
import json
import subprocess
import xmltodict

def read_container_log():
    container = subprocess.getoutput('docker ps -a | grep opentosca_engine-ia_1')
    container = container.split('\n')

    if len(container) != 1:
        print('multiple engine-ia container is detected. quitting....')
        exit()

    else:
        container_container_id = container[0].split()[0]
        cmd = 'docker logs ' + container_container_id
        log = subprocess.getoutput(cmd)
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
            "container_id": tmp[key]
        } for key in tmp]

    print(instance_container_dict)
    return csar_instance_dict, instance_container_dict            

get_csar_instances_containers_id()