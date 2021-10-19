import os
import subprocess
import requests
import json
import pprint

catch_phrase = 'Created container'

def fetch_ia_engine_container_id():
  
  containers = subprocess.getoutput('docker ps -a | grep opentosca_engine-ia')
  containers = containers.split('\n')

  if len(containers) != 1:
    print('multiple engine-ia container is detected. quitting....')
    exit()

  else:
    ia_engine_container_id = containers[0].split()[0]
    return ia_engine_container_id

def fetch_ia_engine_log(container_id):
  command = 'docker logs {}'.format(container_id)
  ia_engine_log = subprocess.getoutput(command)
  f = open("ia_engine_log.txt", 'w')
  f.write(ia_engine_log)
  f.close()
  return ia_engine_log

def fetch_opentosca_generated_container_ids(log):
  global catch_phrase
  logs = log.split('\n')

  container_ids = []

  for l in logs:
    if l.find(catch_phrase) != -1:
      # print(l)
      container_id = l.split()[-1]
      container_ids.append(container_id)
  
  print('container_ids')
  for container_id in container_ids:
    print('-',container_id)
  print()
  
  return container_ids

def get_status_of_containers(container_ids):
  print(container_ids)
  command = 'docker stats {}'.format(container_ids)
  output = subprocess.getoutput(command)
  print(output)


def get_installed_csar_names():
  response_in_json = requests.get('http://ec2-13-124-245-193.ap-northeast-2.compute.amazonaws.com:1337/csars').json()

  response_in_json_pretty = make_pretty(response_in_json)
  # print(response_in_json_pretty)

  csars = response_in_json['csars']
  csars_pretty = make_pretty(csars)
  print(csars_pretty)

  csar_names = []
  for csar in csars:
    csar_name_with_extensions =csar['id']
    csar_names.append(csar_name_with_extensions.split('.')[0])

  return csar_names;

def make_pretty(json_object):
  return json.dumps(json_object, indent=2, sort_keys=True)

def get_instance_ids(csar_name):
  url= "http://ec2-13-124-245-193.ap-northeast-2.compute.amazonaws.com:1337/csars/{}.csar/servicetemplates/{}/instances".format(csar_name,csar_name)
  response_in_json = requests.get(url).json()
  service_template_instances = response_in_json.get('service_template_instances')
  ids = [instance.get('id') for instance in service_template_instances]
  return ids

def main():

  # get container_ids that is created by IA-engine
  ia_engine_container_id = fetch_ia_engine_container_id()
  ia_engine_log = fetch_ia_engine_log(ia_engine_container_id)
  container_ids = fetch_opentosca_generated_container_ids(ia_engine_log)

  csar_names = get_installed_csar_names()
  print('csar_names', csar_names)

  instance_ids = {}
  for csar_name in csar_names:
    ids = get_instance_ids(csar_name)
    instance_ids[csar_name] = ids

  print('instance_ids')
  print(instance_ids)
  # get current status of containers created by IA-engine
  # get_status_of_containers(container_ids)


def instance_id_to_csar():
  return

if __name__ == '__main__':
  main()