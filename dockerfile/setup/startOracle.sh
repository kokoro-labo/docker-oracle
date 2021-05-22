#!/bin/bash

source /home/oracle/.bashrc

# Start listener

checkListener=`ps aux | grep -i 'tnslsnr' | grep -v grep | wc -l`
if [ $checkListener -eq 0 ]; then
  printf "\n>>> start listener\n"
  lsnrctl start
else
  printf "\n>>> Listener is already running\n"
fi

# Start database

checkOracle=`ps aux | grep -i 'ora_' | grep -v grep | wc -l`
if [ $checkOracle -gt 1 ]; then
  printf "\n>>> Oracle is already running\n"
  exit 1
fi

printf "\n>>> start oracle\n"
sqlplus / as sysdba << EOF
   STARTUP;
   alter pluggable database all open;
   show pdbs;
   exit;
EOF

exit 0