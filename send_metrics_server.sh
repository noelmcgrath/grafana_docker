#!/bin/bash 
COUNTER=0
RANGE1=200
RANGE2=100

while [  $COUNTER -lt 10000 ]; do
	server1=$RANDOM
	let "server1 %= $RANGE1+100"
echo server1 $server1

	server2=$RANDOM
	let "server2 %= $RANGE2"
echo server2 $server2
	echo The counter is $COUNTER
	let COUNTER=COUNTER+1
	
	echo "env.myapp.server1.myservice:$server1|ms" | nc -w 1 -u localhost 8125
	echo "env.myapp.server2.myservice:$server2|ms" | nc -w 1 -u localhost 8125
	
	if [ $(( $COUNTER % 10 )) -eq 0 ] ; then
		 echo "deploy:1|c" | nc -w 1 -u localhost 8125
	fi
done
