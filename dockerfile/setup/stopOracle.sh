#!/bin/bash

source /home/oracle/.bashrc

# stop database
echo "\n>>> stop oracle"
sqlplus / as sysdba << EOF
   alter pluggable database all close;
   show pdbs;
   shutdown immediate;
   exit;
EOF

# stop listener
echo "\n>>> stop listener"
lsnrctl stop
