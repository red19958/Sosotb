#!/bin/bash

count=$2
N=$1

for ((i=0;i<$count;i++))
do
	bash newmem.bash $N&
	sleep 1
done
