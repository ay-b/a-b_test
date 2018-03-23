#!/bin/bash 
RESP_A=0
RESP_B=0
COUNTER=0
while [ $COUNTER -lt 1000 ]; do
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
        echo "wtf"
    fi
    ((COUNTER++))
done
echo 
echo "A": $RESP_A, "B:" $RESP_B