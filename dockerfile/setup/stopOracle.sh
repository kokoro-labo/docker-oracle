#!/bin/bash

source /home/oracle/.bashrc

# stop database
echo ">>> stop oracle"
sqlplus / as sysdba << EOF
   alter pluggable database all close;
   show pdbs;
   shutdown immediate;
   exit;
EOF

# stop listener
echo ">>> stop listener"
lsnrctl stop
