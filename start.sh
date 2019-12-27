#!/bin/bash

export xUID=$(id -u)
export xGID=$(id -g)

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Windows;;
    MINGW*)     machine=Windows;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" == "Windows" ] ; then
  WINPTY="winpty"
else
  SUDO="sudo -EHu app"
fi

if ! grep -q azalist ~/.bash_aliases 2>/dev/null; then
  cat >> ~/.bash_aliases <<EOF
alias azalist='az account list --query [].name'
alias azaset='az account set -s'
alias azashow='az account show --query name'
EOF
fi

if [ "$1" == "build" ]; then
  docker-compose build
  exec $WINPTY docker-compose run --rm ansible
else
  exec $WINPTY docker-compose run --rm ansible
fi
