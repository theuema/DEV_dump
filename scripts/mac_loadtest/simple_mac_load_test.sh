#!/bin/bash

open -a Terminal.app gotop.command

NUMCPUS=`sysctl -n hw.ncpu`

waitlist=""
for ((i=1; i<=$NUMCPUS; i++)) ; do
      echo Starting openssl instance $i...
      openssl speed &
      instances[$i]=$!
      waitlist="${instances[$i]} $waitlist"
done

trap "kill $waitlist" SIGINT SIGTERM
wait $waitlist

echo -e "\n\n Finished."
