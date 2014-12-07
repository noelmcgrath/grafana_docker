#!/bin/bash 
COUNTER=0
RANGE1=200
RANGE2=100

while [  $COUNTER -lt 10000 ]; do
	echo The counter is $COUNTER
	let COUNTER=COUNTER+1

	let "myfakeappserver1Service1 =($RANDOM% 100)+200"
	echo myfakeappserver1Service1 $myfakeappserver1Service1
	let "myfakeappserver2Service1 =($RANDOM% 100)"
	echo myfakeappserver2Service1 $myfakeappserver2Service1

	echo "myfakeapp.server1.myservice1:$myfakeappserver1Service1|ms" | nc -w 1 -u localhost 8125
	echo "myfakeapp.server2.myservice2:$myfakeappserver2Service1|ms" | nc -w 1 -u localhost 8125



	let "myotherappserver1good =($RANDOM% 100)+100"
	echo myotherappserver1good $myotherappserver1good
	let "myotherappserver1bad =($RANDOM% 100)"
	echo myotherappserver1bad $myotherappserver1bad
	echo "myotherapp.logins.good:$myotherappserver1good|c" | nc -w 1 -u localhost 8125

	if [ $(( $COUNTER % 5 )) -eq 0 ] ; then
		echo "myotherapp.logins.bad:myotherappserver1bad|c" | nc -w 1 -u localhost 8125
	fi

	if [ $(( $COUNTER % 10 )) -eq 0 ] ; then
		 echo "deploy:1|c" | nc -w 1 -u localhost 8125
	fi
done
 