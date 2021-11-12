# OpenTOSCA instance monitor
project to serve monitoring function to OpenTOSCA users.  

this project is developed using
- flutter SDK v2.5.3 (to make website)
- django (to make RESTful API server)

### System Overview


### Preview

### Features
- show installed ServiceTemplates' topologies
- realtime docker container metrics within OpenTOSCA instance
- able to select metrics to watch

### Prerequisites
first, you has to be able to execute OpenTOSCA itself.
you may reference how to use opentosca at [OpenTOSCA-docker](https://github.com/OpenTOSCA/opentosca-docker)

some limitations exist to run this system
host docker engine
1. has to open external port (ex. 2200)  
2. docker engine has to allow CORS policy
you may achieve docker engine with following scripts  
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
