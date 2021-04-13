#!/bin/bash
arg1=$1
arg2=$2
arg3=$3
sudo systemctl status docker || systemctl  docker #start docker demon if it is not running
exists=$( docker container ls -a -f name="$2" | wc -l ) #check whether container exists. If yes, $exit==2
echo "$exists"
if [[ $arg1 == "start" ]] | [[ $arg1 == "stop" ]] | [[ $arg1 == "create" ]]; then
  case $arg1 in

  start) #start the container and print error message if not created
    if [[ "$exists" == 2 ]]; then
      docker start "$arg2"
    else
      echo sorry, cannot start the specified container as it is not created
    fi
    exit $?
  ;;

  stop) #stop the container and print error message if it is not created
    if [[ "$exists" == 2 ]]; then
      docker stop "$arg2"
    else
      echo sorry, cannot stop the container as it is not created
    fi
    exit $?
  ;;

  create)
    if [[ "$exists" == 2 ]]; then #if the container already exists
      echo The container already exists!
      echo usage:
      docker stats "arg2"
    else
      if [ "$arg2" != '' ] && [ "$arg3" != '' ]; then #creates psql container with the given username and password
        docker volume create pgdata
        docker run --name="$arg2" -e POSTGRES_PASSWORD="$arg3" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgrese
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
exit 0''

