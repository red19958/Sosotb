#!/bin/bash


if [[ $# -ne 1 ]] 
then 
	echo "just 1 argument is needed"
	exit 1
fi

cd /root
name=$1
files=$(cat trash.log)

for i in $files
do
  if [[ $i =~ "$name:" ]]
	then
		echo $i
		echo "Restore?(Y/N)"
		read ans
		if [ $ans = "Y" ]
		then
			cd /root/.trash
			filename=$(echo $i | awk -F":" '{print $2}')
			dir="$(echo $i | awk -F":" '{print $1}' | grep -o ".*/")"
			dirname=$(echo $dir | rev | cut -c 2- | rev)
			if [ -d $dirname ]
			then	
				if [ -e $filename ]
				then
					if [ -e $dir$1 ]
					then
						echo "file with this name is already exists, rename it?(Y/N)"
						read secAns
						if [ $secAns = "Y" ]
						then
              						echo "file named $1$filename"
							ln $filename "$dir$1$filename"
							rm $filename
						fi
					else 
						ln $filename $dir$1
						rm $filename
					fi
				else
					echo "file was already restored"
				fi
			else 
				cd /root/.trash
				echo "noDirectory"
				if [ -e $filename ]
				then
					cd /root
					if [ -e $1 ]
					then
						echo "file with this name is already exist, rename it?(Y/N)"
						read secAns
						if [ $secAns = "Y" ]
						then
              						echo "file named $1$filename"
							ln /root/.trash/$filename $1$filename
							rm /root/.trash/$filename
							echo "file was restored in home catalog"
						fi
					else 
						ln /root/.trash/$filename $1
						rm /root/.trash/$filename
						echo "file was restored in home catalog"
					fi
				else
					echo "file was already restored"
				fi
			fi
		fi	
	fi
done
