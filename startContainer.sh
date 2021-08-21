#!/bin/bash

if [ $# -ne 1 ];then
    printf "\n>>> Please input container-name.\n"
    exit 1
fi

cName=$1
cService=`docker inspect --format '{{ index .Config.Labels "com.docker.compose.service"}}' "$cName"`

printf "\n>>> start container\n"
docker-compose start "$cService"
sleep 5s

# Start Listener and Oracle
docker exec -u oracle "$cName" /home/oracle/startOracle.sh

exit 0