#!/bin/bash
dockerComand=$1
containerName=$2
sudo systemctl status docker || systemctl  docker #start docker demon if it is not running
exists=$( docker container ls -a -f name="$arg2" | wc -l ) #check whether container exists. If yes, $exists==2
if [[ $dockerComand == "start" ]] | [[ $dockerComand == "stop" ]] | [[ $dockerComand == "create" ]]; then
  case $dockerComand in

  start) #start the container and print error message if not created
    if [[ "$exists" == 2 ]]; then
      docker start "$containerName"
    else
      echo sorry, cannot start the specified container as it is not created
    fi
    exit $?
  ;;

  stop) #stop the container and print error message if it is not created
    if [[ "$exists" == 2 ]]; then
      docker stop "$containerName"
    else
      echo sorry, cannot stop the container as it is not created
    fi
    exit $?
  ;;

  create)
    userName=$2
    password=$3
    if [[ "$exists" == 2 ]]; then #if the container already exists
      echo The container already exists!
      echo usage:
      docker stats "$containerName"
    else
      if [ "$userName" != '' ] && [ "$password" != '' ]; then #creates psql container with the given username and password
        docker volume create pgdata
        docker run --name="$userName" -e POSTGRES_PASSWORD="$password" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgrese
      else #gives error message if username and password is missing
        echo please provide username and password
      fi
      exit $?
    fi
    exit $?
  ;;
  esac
else
  echo please enter valid options from start, stop or create with username nd password
fi
exit 0

