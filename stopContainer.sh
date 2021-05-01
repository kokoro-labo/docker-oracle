#!/bin/bash

# Stop Oracle and Listener
docker exec -u oracle ora19 /home/oracle/stopOracle.sh
sleep 5s

printf "\n>>> stop container\n"
docker stop ora19
