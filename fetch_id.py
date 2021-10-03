import os
import subprocess

catch_phrase = 'Created container'

def fetch_ia_engine_container_id():
  
  containers = subprocess.getoutput('docker ps -a | grep opentosca_engine-ia')
  containers = containers.split('\n')

  if len(containers) != 1:
    print('multiple engine-ia container is detected')

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
      print(l)
      container_id = l.split()[-1]
      container_ids.append(container_id)
  
  return container_ids

def main():

  # fetching container id of ia-engine
  ia_engine_container_id = fetch_ia_engine_container_id()
  
  ia_engine_log = fetch_ia_engine_log(ia_engine_container_id)

  container_ids = fetch_opentosca_generated_container_ids(ia_engine_log)

  print(container_ids)



if __name__ == '__main__':
  main()