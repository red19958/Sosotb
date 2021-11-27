#!/bin/bash

cd /root
if [[ ! -d restore ]]
then 
	mkdir restore
fi

back="$(ls | grep -E "^Backup-" | sort -V | tail -1 )"
cd /root/$back
files="$(ls)"
for i in $files
do
	notFresh="$(echo "$i" | grep -E -o '^[A-Za-z0-9]+-[0-9]+-[0-9]+-[0-9]+')"
	if [ "$i" != "$notFresh" ]
	then
		cp -R $i /root/restore
	fi
done
