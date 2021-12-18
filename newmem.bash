#!/bin/bash


maxSize=$1
array=()
iter=1
while true
do
	array+=(1 2 3 4 5)
	if [[ ${#array[*]} -ge $maxSize ]]
	then
		exit
	fi
	let iter=$iter+1
done
