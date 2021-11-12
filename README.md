# OpenTOSCA instance monitor
project to serve monitoring function to OpenTOSCA users. API server internally parses static logs from OpenTOSCA components (IA-Engine, Container (not docker-container. name for OpenTOSCA runtime) and send needed informations (Application Topology, installed CSARs and their instances, docker-container within specific instances) to Web Client built by Flutter SDK. Web Client has module named `MetricsProvider` where docker-container-id is registered and their metrics are managed.

this project is developed using
- flutter SDK v2.5.3 (to make website)
- django (to make RESTful API server)

### System Overview
![system_architecture](https://user-images.githubusercontent.com/22641543/141505262-ed78349e-a1b1-4b56-9329-161fe998e961.png)

### Preview
![ui](https://user-images.githubusercontent.com/22641543/141505612-e53c2e1c-e2d4-443b-9a47-1167a2fec081.png)

### Features
- show installed ServiceTemplates' topologies
- realtime docker container metrics within OpenTOSCA instance
- able to select metrics to watch

### Prerequisites
> First, you has to be able to execute OpenTOSCA itself.  
you may reference how to use opentosca at [OpenTOSCA-docker](https://github.com/OpenTOSCA/opentosca-docker)
  

Some pre-work exist to run this system  
host docker engine
1. has to open external port (ex. 2200)  
2. docker engine has to allow CORS policy

you may achieve docker engine setting with below scripts 
``` shell
sudo dockerd -H 0.0.0.0:2220 --api-cors-header=* -H unix:///var/run/docker.sock &
```

### How to Start

copy from `_.env` file and adjust ${PUBLIC_HOSTNAME} into your server's public or private IP address  
then run (you may need to run this command as root-user)
```
docker compose up
```

### limitations
for now,
- metrics panel are showing only recent 8 datas
- unable to show another NodeType's metrics except docker-container
domain knowledge about each NodeType will be needed
