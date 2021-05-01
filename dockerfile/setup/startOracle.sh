#!/bin/bash

source /home/oracle/.bashrc

# Start listener
printf "\n>>> start listener\n"
lsnrctl start

# Start database
printf "\n>>> start oracle\n"
sqlplus / as sysdba << EOF
   STARTUP;
   alter pluggable database all open;
   show pdbs;
   exit;
EOF
