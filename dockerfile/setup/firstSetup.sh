#!/bin/bash

source /home/oracle/.bashrc

# First Oracle Setup
printf "\n>>> first oracle setup\n"
sqlplus / as sysdba << EOF
    CONN /as SYSDBA;
    SHOW CON_NAME;

    /* Change SYS password */
    ALTER USER SYS IDENTIFIED BY password;

    /* Change DEFAULT's password_life_time */
    ALTER PROFILE default LIMIT password_life_time UNLIMITED;

    ALTER SESSION SET CONTAINER=ORCLPDB1;
    SHOW CON_NAME;

    /* Create USER for PDB */
    CREATE USER test IDENTIFIED BY password DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS TEMPORARY TABLESPACE TEMP;
    GRANT DBA TO test;
    GRANT UNLIMITED TABLESPACE TO test;

    /* Check USER status */
    set line 200
    COL pdb_name FORMAT a8
    COL username FORMAT a8
    COL granted_role FORMAT a12
    COL profile FORMAT a7
    COL pass_limit FORMAT a10
    COL default_tablespace FORMAT a18
    SELECT
        cp.pdb_name,
        cu.username,
        drp.granted_role,
        cu.profile,
        dp.limit as PASS_LIMIT,
        cu.default_tablespace,
        dtq.bytes / 1024 / 1024 as TABLESPACE_MB
    FROM
        (((cdb_users cu INNER JOIN dba_role_privs drp ON cu.username = drp.grantee AND cu.username = 'TEST')
        INNER JOIN dba_profiles dp ON cu.profile = dp.profile AND dp.resource_name = 'PASSWORD_LIFE_TIME')
        INNER JOIN dba_ts_quotas dtq ON cu.username = dtq.username)
        INNER JOIN cdb_pdbs cp ON cu.con_id = cp.pdb_id ;
    exit;
EOF