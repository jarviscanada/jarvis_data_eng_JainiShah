# Linux Cluster Monitoring Agent
# Introduction
The Linux Cluster Monitoring Agent tool help users to record the hardware specifications of each node in a linux cluster and monitor the resource usage at a particular interval of time. Thus, it enhances the decision-making ability of a resource manager.    
# Quick Start 
- Start a psql instance using psql_docker.sh
````bash
./scripts/psql_docker.sh start
````
- Create tables using ddl.sql
````bash
./sql/ddl.sql 
````
- Insert hardware specs data into the db using host_info.sh
````bash
./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password
````
- Insert hardware usage data into the db using host_usage.sh
````bash
starscripts/host_usage.sh psql_host psql_port db_name psql_user psql_passwordt
````
- Crontab setup
````bash
crontab -e
````

# Implementation
A postgreSQL instance is provisioned by creating and starting a docker container. The program is implemented using linux command lines and scripts like host_info.sh and host_usage.sh are used to insert data and ddl.sql is used to create tables. At last, crontab is set up to monitor the usage for a specific time interval.
## Architecture
![ClusterDiagram](./assets/ClusterDiagram.jpg)
## Scripts
- psql_docker.sh:: 
This script creates psql instance with the given database name and password using docker and allows user to access it on the local machine.  
````bash
./scripts/psql_docker.sh start|stop|create (db_username)(db_password)
````  
- host_info.sh::
This script runs only once assuming hardware data is static and allows user to collect hardware specifications which is then inserted into the database table called host_info(psql instance)
````bash
./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password
````  
- host_usage.sh::
This script collects the server usage data and is executed repeatedly in a specific interval of time and then stores data to psql database    
````bash
.scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password
````
- crontab::
Crontab helps to execute the psql_usage.sh script every minute and collect the usage data. 
## Database Modeling 
The database host_agent consists of two tables, host_info to store the hardware specifications and second, host_usage to store resource usage data.
- `host_info`
````bash
#Schema of host_info table
#All the values in both table is set to NOT NULL 
id: This is the unique number associated with each node and it is the primary key which is auto incremented by PostgreSQL
hostname: This is varchar type data and stores the hostname 
cpu_number: This is an integer type data which stores the number of cpu of the host
cpu_architecture: A varchar type data stores the cpu architecture information
cpu_model: This is an integer type field and stores the model of cpu
cpu_mhz: This is an integer type field which stores the cpu speed information 
l2_cache: This is varchar type field which stores the level 2 cache memory of cpu in KB
total_mem: This is an integer type field which stores the total memory available for cpu in KB  
timestamp: This is a timestamp type field which stores current timestamp in UTC time zone 

#Schema of host_usage table
timestamp: This is a timestamp type field which stores current time in UTC time zone
host_id: This the id of the host corresponding to the id in host_info table. It is the foreign key.
memory_free: This is an integer type field which stores total free memory of the disk in MB
cpu_idle: This is an integer type field which stores the percentage of cpu idle
cpu_kernel: This is an integer type field which stores the percentage of CPU time spent on kernel processes. 
disk_io: This is an integer type field which stores total current disk reads or writes.
disk_available: This is an integer type field which stores the available disk blocks in MB
``````

# Test 
To test the scripts and sql queries, the first step is to connect the psql instance with the help of psqldocker.sh script and change the mode of each file to executable mode. ddl.sql file is executed to create the tables host_info and host_usage if does not exist. host_info.sh and host_info.sh scripts are executed to retrieve the hardware information and resource usage information which is stored in a variable and then the data is inserted through psql CLI tool. Crontab is set up to run the host_usage.sh script every minute to monitor the resource usage. 
At last, sql queries are executed with the help of dbeaver GUI client to get the average memory usage in percentage for a fixed interval of time and hardware information grouped by cpu hosts.   

# Improvements
1. Create an automated script to connect to the psql instance 
2. Handle the hardware update and insert the new hardwware specifications into host_info 
3. Find a way to use windows function to group hosts by cpu number without use of aggregate functions

