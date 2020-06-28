#!/bin/bash

./run-benchmark.sh opcache amphp
./run-benchmark.sh jit amphp

export CONNECTIONS=800
export RPS_LIST="10k 15k 20k 21k 22k"
./run-benchmark.sh opcache amphp
./run-benchmark.sh jit amphp

export CONNECTIONS=1000
export RPS_LIST="15k 20k 21k 22k"
./run-benchmark.sh opcache amphp
./run-benchmark.sh jit amphp
