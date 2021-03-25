#!/bin/bash

sudo systemctl status docker || systemctl start docker
if [[ $1 == "start" ]] | [[ $1 == "stop" ]] | [[ $1 == "create" ]] ; then
  case $1 in
    start)
      docker container start jrvs-psql
      exit $?
      ;;
    stop)
      docker container stop jrvs-psql
      exit $?
      ;;
    create)
      if ( docker container ls -a -f name=jrvs-psql | wc -l == 2); then
        echo Container already exists
        echo Usage:
        docker stats jarvs-psql
      exit 1
      else
        if [[ $2 -eq 0 ]] | [[ $3 -eq 0 ]]; then
          echo Please provide username and password
        exit 1
        else
          docker volume create pgdata
          docker run --name="$2" -e POSTGRES_PASSWORD="$3" -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres
        exit 1
        fi
      fi
  esac
else
  echo Please enter valid option
fi
#if [[ $2 -eq 0 ]] ; then
exit 0''


