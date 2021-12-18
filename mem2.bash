#!/bin/bash

array=()
iter=1
echo "" > report2.log
while true
do
	array+=(1 2 3 4 5)
	if [[ $iter -eq 100000 ]]
	then
		iter=0
		echo ${#array[*]} >> report2.log
	fi
	let iter=$iter+1
done
