#!/bin/bash

printf "\n>>> start container\n"
docker start ora19
sleep 5s

# Start Listener and Oracle
docker exec -u oracle ora19 /home/oracle/startOracle.sh
