#!/bin/bash

usage() {
    echo "Usage: $0 [start|stop|pause|unpause] (docker-tag)"
    exit 1
}

if [ $# -eq 1 ]; then
    CMD=$1
    TAG=latest
elif [ $# -eq 2 ]; then
    CMD=$1
    TAG=$2
else
    usage
fi

startDocker() {
    local dockerEnv=$1
    local port=$2
    echo ">>> START $dockerEnv $port $TAG"
    docker run -dit -v $PWD:/testsuite -p $port:$port \
        --env-file data/dockerenv/$dockerEnv \
        --name gochain-$dockerEnv \
        goloop/gochain-icon:$TAG
}

stopDocker() {
    echo ">>> STOP gochain-$1"
    docker stop gochain-$1
    docker rm gochain-$1
}

pauseDocker() {
    echo ">>> PAUSE gochain-$1"
    docker pause gochain-$1
}

unpauseDocker() {
    echo ">>> UNPAUSE gochain-$1"
    docker unpause gochain-$1
}

DOCKER_ENV=iconee
PORT=9082

case "$CMD" in
  start )
    startDocker $DOCKER_ENV $PORT
  ;;
  stop )
    stopDocker $DOCKER_ENV
  ;;
  pause )
    pauseDocker $DOCKER_ENV
  ;;
  unpause )
    unpauseDocker $DOCKER_ENV
  ;;
  * )
    echo "Error: unknown command: $CMD"
    usage
esac
