#!/bin/bash -x
RESP_A=0
RESP_B=0
COUNTER=0
# Replace 10000 with any desired amounts of tests against randomizer.
while [ $COUNTER -lt 10000 ]; do
    CONTENT="$(curl -sSL localhost)"
    if [[ $(echo $CONTENT | cut -c 1) == "b" ]];
    then
        ((RESP_B++))
        echo -n "="
    elif [[ $(echo $CONTENT | cut -c 1) == "a" ]];
    then
        ((RESP_A++))
        echo -n "-"
    else 
        echo "error"
    fi
    ((COUNTER++))
done
echo 
echo "A": $RESP_A, "B:" $RESP_B
echo -e 'HTTP_200="HTTP/1.1 200 OK"\n\n' > log.txt
echo "A": $RESP_A, "B:" $RESP_B >> log.txt
# Uncomment to launch a single response web-server with stats.
# nc -l 8090 < log.txt