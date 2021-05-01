#!/bin/bash

source /home/oracle/.bashrc

# stop database
printf "\n>>> stop oracle\n"
sqlplus / as sysdba << EOF
   alter pluggable database all close;
   show pdbs;
   shutdown immediate;
   exit;
EOF

# stop listener
printf "\n>>> stop listener\n"
lsnrctl stop
