#!/bin/bash

[[ $DEBUG ]] && set -x

case $1 in
"debug")
  /bin/bash;;
"version")
  echo "PHP:$PHP_VERSION"
  echo "Apache: $APACHE_VERSION";;
*)
  exec $@
esac
