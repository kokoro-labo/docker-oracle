# docker-oracle

Use the Oracle database for learning

## Prepare

### Before BUILD

Place the RPM in the specified directory

```
dockerfile/rpm/oracle-database-*.rpm
```

### After BUILD

Run firstSetup.sh

The sh performs the following processing

* Set SYS password
* Create PDB's user as DBA
* Check PDB's user status

```
docker-compose start
docker exec -it -u oracle ora19 /home/oracle/firstSetup.sh
```

## Startup

Container start and Oracle startup

```
sh startContainer.sh
```

or

```
docker-compose start
docker exec -it -u oracle ora19 /home/oracle/startOracle.sh
```

## hutdown

Oracle shutdown and Container stop

```
sh stopContainer.sh
```

or

```
docker exec -it -u oracle ora19 /home/oracle/stopOracle.sh
docker-compose stop
```

## Use Images

* CentOS7

