#!/bin/sh

set -e

command="/usr/local/bin/php"
if [ "$1" == "jit" ]
then
  shift
  command="/usr/local/bin/php -dzend_extension=opcache.so -dopcache.enable_cli=1 -dopcache.jit_buffer_size=100M -dopcache.jit=1205"
fi

if [ "$1" == "opcache" ]
then
  shift
  command="/usr/local/bin/php -dzend_extension=opcache.so -dopcache.enable_cli=1"
fi

$command $@