#!/bin/bash

export SERVER_CORE=${SERVER_CORE:-13}
CPUS_CORES=${CPUS_CORES:-0-12}
WORKER_THREADS=${WORKER_THREADS:-12}
DURATION=${DURATION:-1m}
CONNECTIONS=${CONNECTIONS:-500}

TYPE=$1
SERVICE=$2

export TEST_NAME="$TYPE-$SERVICE"

mkdir -p results/$TEST_NAME

function start_server() {
  docker run --rm -it -d --network=host --name=$TEST_NAME --cpuset-cpus="$SERVER_CORE" -v $(pwd):/usr/src/app php8-alpha $@
}

function stop_server() {
  docker stop $TEST_NAME
}



for RPS in 1k 5k 10k 15k 17k 18k 20k 21k 22k 23k 24k
do
  start_server $TYPE bin/$SERVICE-http-server.php
  OUTPUT=results/$TEST_NAME/$RPS.txt
  docker run --rm --network=host -it --cpuset-cpus "$CPUS_CORES" 1vlad/wrk2-docker -t$WORKER_THREADS -c$CONNECTIONS -d$DURATION -R$RPS --latency http://localhost:8888/ > $OUTPUT
  stop_server
done

grep -A11 -e "Thread Stats\s*Avg\s*Stdev\s*Max\s*.*\s*Stdev" results/$TEST_NAME/*k.txt > results/$TEST_NAME/summary.txt

cat results/$TEST_NAME/summary.txt