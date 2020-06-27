#!/bin/bash

FREQUENCY=$1

if [[ "$FREQUENCY" == "" ]]
then
  echo "Usage: $0 [cpu_frequency]"
  exit 1
fi

sudo cpupower frequency-set -r -f $FREQUENCY
sudo cpupower frequency-set -g performance
