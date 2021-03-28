#!/bin/bash

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#Error message for missing arguments
if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters. Please provide psql host, port number, database name, user and password"
    exit 1
fi

#parsing host hardware specifications
hostname=$(hostname -f)
cpu_number=$(lscpu | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(lscpu | egrep "^Architecture:" | awk '{print $2}' | xargs)
cpu_model=$(lscpu | egrep "^Model:" | awk '{print $2}' | xargs)
cpu_mhz=$(lscpu | egrep "^CPU\sMHz:" | awk '{print $3}' | xargs)
l2_cache=$(lscpu | egrep "^L2\scache:" | awk '{print $3}' | xargs)
total_mem=$(cat proc/meminfo | egrep "MemTotal:" | awk '{print $2}' | xargs)
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

exit 0