#!/bin/bash

echo "\n>>> start container"
docker start ora19
sleep 5s

echo "\n>>> start oracle"
docker exec -u oracle ora19 /home/oracle/startOracle.sh
