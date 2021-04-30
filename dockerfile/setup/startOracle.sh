#!/bin/bash

source /home/oracle/.bashrc

# Start listener
echo "\n>>> start listener"
lsnrctl start

# Start database
echo "\n>>> start oracle"
sqlplus / as sysdba << EOF
   STARTUP;
   alter pluggable database all open;
   show pdbs;
   exit;
EOF
