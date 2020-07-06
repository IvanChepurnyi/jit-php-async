#!/bin/bash

export SERVER_CORE=${SERVER_CORE:-11}
CPUS_CORES=${CPUS_CORES:-0-10}
WORKER_THREADS=${WORKER_THREADS:-10}
DURATION=${DURATION:-40s} # 40 seconds - 10 seconds warm-up = 30 of actual recorded test
CONNECTIONS=${CONNECTIONS:-500}
RPS_LIST=${RPS_LIST:-"5k 10k 15k 19k 20k 21k 22k 23k"}

AUTOCANNON_COUNT=${AUTOCANNON_COUNT:-1000000}
AUTOCANNON_PIPELINE=${AUTOCANNON_PIPELINE:-20}


TYPE=$1
SERVICE=$2

export TEST_NAME="$CONNECTIONS-$TYPE-$SERVICE"

mkdir -p results/$TEST_NAME

function start_server() {
  docker run --rm -it -d --network=host --name=$TEST_NAME --cpuset-cpus="$SERVER_CORE" -v $(pwd):/usr/src/app php8-alpha $@
}

function stop_server() {
  docker stop $TEST_NAME
}


for RPS in $RPS_LIST
do
  start_server $TYPE bin/$SERVICE-http-server.php
  OUTPUT=results/$TEST_NAME/$RPS.txt
  docker run --rm --network=host -it --cpuset-cpus "$CPUS_CORES" 1vlad/wrk2-docker -t$WORKER_THREADS -c$CONNECTIONS -d$DURATION -R$RPS --latency http://localhost:8888/ > $OUTPUT
  stop_server
done

OUTPUT=results/$TEST_NAME-autocannon.json
start_server $TYPE bin/$SERVICE-http-server.php
docker run --rm --network=host -it --cpuset-cpus "$CPUS_CORES" autocannon -c $CONNECTIONS -a $AUTOCANNON_COUNT -p $AUTOCANNON_PIPELINE -j http://localhost:8888/ > $OUTPUT
stop_server