#!/bin/bash

start_svc() {
   while true; do
      echo "hello world" >> /tmp/demo.log;
      sleep 2;
   done 
}

case $1 in
    start) start_svc &
    ;;
    *) exit 0
    ;;
esac

exit 0;
