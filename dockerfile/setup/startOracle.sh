#!/bin/bash

source /home/oracle/.bashrc

# Start listener
echo ">>> start listener"
lsnrctl start

# Start database
echo ">>> start oracle"
sqlplus / as sysdba << EOF
   STARTUP;
   alter pluggable database all open;
   show pdbs;
   exit;
EOF
