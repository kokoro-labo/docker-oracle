#!/bin/bash

source /home/oracle/.bashrc

# First Oracle Setup
printf "\n>>> first oracle setup\n"
sqlplus / as sysdba << EOF
    CONN /as SYSDBA;
    SHOW CON_NAME;
    ALTER USER SYS IDENTIFIED BY password;
    ALTER SESSION SET CONTAINER=ORCLPDB1;
    SHOW CON_NAME;
    CREATE USER test IDENTIFIED BY password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS TEMPORARY TABLESPACE TEMP;
    GRANT DBA TO test;
    GRANT UNLIMITED TABLESPACE TO test;
    SELECT dtq.username, drp.granted_role, tablespace_name, dtq.bytes / 1024 / 1024 as TABLESPACE_MB FROM dba_role_privs drp, dba_ts_quotas dtq WHERE dtq.username = 'TEST' and drp.grantee = dtq.username;
    exit;
EOF