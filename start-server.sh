#!/bin/bash

export SERVER_CORE=${SERVER_CORE:-11}

docker run --rm -it --network=host --cpuset-cpus="$SERVER_CORE" -v $(pwd):/usr/src/app php8-alpha $@