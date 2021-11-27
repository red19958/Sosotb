#!/bin/bash

cd /root
now="$(date +%Y-%m-%d)"
prev="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 2,3,4)"
prevY="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 2)"
prevM="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 3)"
prevd="$(ls | grep -E "^Backup-" | sort -n | tail -1 | cut -d "-" -f 4)"
nowY="$(date +%Y)"
nowM="$(date +%-m)"
nowd="$(date +%-d)"
flag=0
diff=0
if [[ $nowY -gt $prevY ]]
then
  flag=1
elif [[ $nowM -gt $prevM ]]
then 
  flag=1
else
  let diff=$nowd-$prevd
fi

if [[ $diff -gt 7 || $flag == 1 ]]
then 
	mkdir "Backup-$now"
	cd /root/source
	files="$(ls)"
	for i in files
	do
		cp -R $i ~/Backup-$now
	done
	cd /root
	echo "Backup was created $now" >> backup-report
	echo "Copied this files: " >> backup-report
	echo $files >> backup-report
	
else
	cd /root/source
	files="$(ls)"
	cd /root/Backup-$prev
	
	for i in $files 
	do
		if [ -f $i ]
		then
			currentSize=$(ls -l /root/source/$i | awk '{print $5}')
			lastSize=$(ls -l $i | awk '{print $5}')
			if [[ $currentSize -ne $backSize ]]
			then
				mv $i $i-$now
				cp -R /root/source/$i /root/Backup-$prev
				echo "$i was renamed to $i-$now" >> /root/backup-report
			fi
		else
			cp -R /root/source/$i /root/Backup-$prev
		fi
	done	
fi
