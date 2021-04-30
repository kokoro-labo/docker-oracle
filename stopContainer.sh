#!/bin/bash

echo "\n>>> stop oracle"
docker exec -u oracle ora19 /home/oracle/stopOracle.sh
sleep 5s

echo "\n>>> stop container"
docker stop ora19
