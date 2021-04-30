#!/bin/bash

echo "stop oracle"
docker exec -u oracle ora19 /home/oracle/stopOracle.sh
sleep 5s

echo "stop container"
docker stop ora19
