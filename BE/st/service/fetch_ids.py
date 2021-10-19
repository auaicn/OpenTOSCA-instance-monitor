from .fetch_id import ids
import re
import json
import subprocess

file_name = "container_log.log"
date_regex = r"20[0-9][0-9]-[0-9][0-9]-[0-3][0-9] "
time_regex = "\d\d:\d\d:\d\d.\d\d\d"

def read_container_log_file():
    container = subprocess.getoutput('docker ps -a | grep opentosca_container_1')
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
    log = read_container_log_file()
    
    return re.split(date_regex + time_regex, log)

def get_csar_instances_containers_id():
    csar_instance_dict, instance_container_dict = ids()
    logs = log_parsing()

    for l in logs:
        if "SERVICEINSTANCEID_URI" in l and "ContainerID" in l:
            x = re.split(r': ', l)
            xml_string = x[-1]
            xml_key = re.findall(r"<key>(.+?)</key>", xml_string)
            xml_value = re.findall(r"<value>(.+?)</value>", xml_string)

            xml = {xml_key[i] : xml_value[i] for i in range(len(xml_key))}
            container_id = xml.get("ContainerID")

            x = re.findall(r'SERVICEINSTANCEID_URI=(.+?),', l)
            uri = x[0].split('/')
            instance_id = int(uri[-1])

            instance_container_dict[instance_id].append(container_id)

    return csar_instance_dict, instance_container_dict            