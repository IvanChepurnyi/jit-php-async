#!/bin/bash

docker build docker/php -t php8-alpha
docker build docker/autocannon -t autocannon