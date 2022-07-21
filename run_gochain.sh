#!/bin/bash

TARGET=${TARGET:-single}

usage() {
    echo "Usage: $0 [start|stop|pause|unpause|ps]"
    exit 1
}

if [ $# -eq 1 ]; then
    CMD=$1
else
    usage
fi

startDocker() {
    echo ">>> START with compose-$1.yml"
    docker-compose -f compose-$1.yml up -d
}

stopDocker() {
    echo ">>> STOP with compose-$1.yml"
    docker-compose -f compose-$1.yml down
}

pauseDocker() {
    echo ">>> PAUSE with compose-$1.yml"
    docker-compose -f compose-$1.yml pause
}

unpauseDocker() {
    echo ">>> UNPAUSE with compose-$1.yml"
    docker-compose -f compose-$1.yml unpause
}

psDocker() {
    docker-compose -f compose-$1.yml ps
}

case "$CMD" in
  start )
    startDocker $TARGET
  ;;
  stop )
    stopDocker $TARGET
  ;;
  pause )
    pauseDocker $TARGET
  ;;
  unpause )
    unpauseDocker $TARGET
  ;;
  ps )
    psDocker $TARGET
  ;;
  * )
    echo "Error: unknown command: $CMD"
    usage
esac
