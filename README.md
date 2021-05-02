# docker-oracle

Use the Oracle database for learning based on OTN LICENSE

## Prepare

### Before Container Build

Place the RPM in the specified directory

```
dockerfile/rpm/oracle-database-*.rpm
```

### After Container Build

Run firstSetup.sh

The sh performs the following processing

* Change SYS password
* Change DEFAULT PROFILE password_life_time
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

## Shutdown

Oracle shutdown and Container stop

```
sh stopContainer.sh
```

or

```
docker exec -it -u oracle ora19 /home/oracle/stopOracle.sh
docker-compose stop
```

## Use

Use Oracle

```
docker exec -it -u oracle ora19 /bin/bash
sqlplus TEST@ORCLPDB1
```

## Use Images

* CentOS7

