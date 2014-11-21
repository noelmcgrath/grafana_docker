#!/bin/bash 
COUNTER=0
RANGE1=200
RANGE2=100

while [  $COUNTER -lt 10000 ]; do
	echo The counter is $COUNTER
	let COUNTER=COUNTER+1

	let "myappserver1Service1 =($RANDOM% 100)+100"
	echo myappserver1Service1 $myappserver1Service1
	let "myappserver2Service1 =($RANDOM% 100)+100"
	echo myappserver2Service1 $myappserver2Service1

	echo "myapp.server1.myservice1:$myappserver1Service1|ms" | nc -w 1 -u localhost 8125
	echo "myapp.server1.myservice2:$myappserver2Service1|ms" | nc -w 1 -u localhost 8125

	echo "myotherapp.logins.good:2|c" | nc -w 1 -u localhost 8125

	if [ $(( $COUNTER % 5 )) -eq 0 ] ; then
		echo "myotherapp.logins.bad:1|c" | nc -w 1 -u localhost 8125
	fi

	if [ $(( $COUNTER % 10 )) -eq 0 ] ; then
		 echo "deploy:1|c" | nc -w 1 -u localhost 8125
	fi
done
 