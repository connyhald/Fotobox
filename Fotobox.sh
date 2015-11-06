#!/bin/bash

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`

# Restart Fotobox in case of crash
while true; do
  $DIR/Fotobox
  sleep 2
done


