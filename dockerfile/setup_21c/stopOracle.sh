#!/bin/bash

source /home/oracle/.bashrc

# Stop Oracle

checkOracle=`ps aux | grep -i 'ora_' | grep -v grep | wc -l`
if [ $checkOracle -gt 1 ]; then
  printf "\n>>> Stop Oracle\n"
  sqlplus / as sysdba << EOF
     alter pluggable database all close;
     show pdbs;
     shutdown immediate;
     exit;
EOF
else
  printf "\n>>> Oracle is already stopped\n"
fi

# Stop Listener

checkListener=`ps aux | grep -i 'tnslsnr' | grep -v grep | wc -l`
if [ $checkListener -gt 0 ]; then
  printf "\n>>> Stop Listener\n"
  lsnrctl stop
else
  printf "\n>>> Listener is already stopped\n"
fi

exit 0