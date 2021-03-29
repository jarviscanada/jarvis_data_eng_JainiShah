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

memory_free=$(vmstat --unit M |awk '{for(i=NF;i>0;i--)if($i=="free"){x=i;break}}END{print $x}' | xargs)
cpu_idle=$(vmstat --unit M |awk '{for(i=NF;i>0;i--)if($i=="id"){x=i;break}}END{print $x}' | xargs)
cpu_kernel=$(vmstat --unit M |awk '{for(i=NF;i>0;i--)if($i=="sy"){x=i;break}}END{print $x}' | xargs)
disk_io=(vmstat -d |awk '{for(i=NF;i>0;i--)if($i=="cur"){x=i+1;break}}END{print $x}' | xargs)
disk_available=$(df -BM / |awk '{for(i=NF;i>0;i--)if($i=="Available"){x=i;break}}END{print $x}' | xargs)
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
#Query to insert data into host_info table
insert_stmnt="INSERT INTO host_usage(timestamp, , cpu_architecture, cpu_model, cpu_mhz, l2_cache, total_mem, timestamp);"

#Executing Insert statement through psql CLI tool
psql -h localhost -U postgres -d host_agent -c "$insert_stmnt"