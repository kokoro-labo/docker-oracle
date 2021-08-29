#!/bin/bash

source /home/oracle/.bashrc

# Check Oracle Status
printf "\n>>> check oracle status\n"
sqlplus / as sysdba << EOF
    CONN /as SYSDBA;
    col CON_ID form 999
    col NAME format a15
    col OPEN_MODE format a10
    col LOCAL_UNDO form 9999
    select CON_ID, NAME, OPEN_MODE, LOCAL_UNDO from v$containers order by CON_ID;
    exit;
EOF