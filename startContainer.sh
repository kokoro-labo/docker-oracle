#!/bin/bash

echo "start container"
docker start ora19
sleep 5s

echo "start oracle"
docker exec -u oracle ora19 /home/oracle/startOracle.sh
