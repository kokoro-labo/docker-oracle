#!/bin/bash

if [ $# -ne 1 ];then
    printf "\n>>> Please input container-name.\n"
    exit 1
fi

cName=$1
cService=`docker inspect --format '{{ index .Config.Labels "com.docker.compose.service"}}' "$cName"`

# Stop Oracle and Listener
docker exec -u oracle "$cName" /home/oracle/stopOracle.sh
sleep 5s

printf "\n>>> stop container\n"
docker-compose stop "$cService"

exit 0