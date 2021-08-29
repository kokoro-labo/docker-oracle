#!/bin/bash

source /home/oracle/.bashrc

# Start Listener

checkListener=`ps aux | grep -i 'tnslsnr' | grep -v grep | wc -l`
if [ $checkListener -eq 0 ]; then
  printf "\n>>> Start Listener\n"
  lsnrctl start
else
  printf "\n>>> Listener is already running\n"
fi

# Start Oracle

checkOracle=`ps aux | grep -i 'ora_' | grep -v grep | wc -l`
if [ $checkOracle -gt 1 ]; then
  printf "\n>>> Oracle is already running\n"
  exit 1
fi

printf "\n>>> Start Oracle\n"
sqlplus / as sysdba << EOF
   STARTUP;
   alter pluggable database all open;
   show pdbs;
   exit;
EOF

exit 0