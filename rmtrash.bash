#!/bin/bash

if [[ $# -ne 1 ]] 
then 
	echo "just 1 argument is needed"
	exit 1
fi


name=$1
numb=$(cat number)
#number содержит число 1 изначально

if [[ -f $PWD/$name ]]
then 
	echo "file \"$1\" exists"
else 
	echo "no file \"$1\""
	exit 1
fi

if [[ -d ~/.trash ]] 
then 
	echo "directory \".trash\" is already exists"
else 
	mkdir ~/.trash
fi

ln $name $HOME/.trash/$numb
rm $1
echo "$PWD/$name:$numb" >> ~/trash.log && echo "removal completed"
let numb=$numb+1
echo $numb>number
