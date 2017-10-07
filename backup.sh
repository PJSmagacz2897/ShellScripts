#!/usr/local/bin/bash
  file=$1
  backup=$2
  sec=$3
  max=$4
  
  year=$(date +"%Y")
  month=$(date +"%m")
  day=$(date +"%d")
  hour=$(date +"%H")
  minute=$(date +"%M")
  second=$(date +"%S")
  backupName="$2/$year-$month-$day-$hour-$minute-$second-$file"
 
  cp $file $backupName
 
  find $2 -type f | wc -l > output.txt
  size=$(cat output.txt)
 
  while [ 1 ]; do
          sleep $sec
          diff $backupName $1 > toEmail.txt
          if [ -s toEmail.txt ]; then
                  year=$(date +"%Y")
                  month=$(date +"%m")
                  day=$(date +"%d")
                  hour=$(date +"%H")
                  minute=$(date +"%M")
                  second=$(date +"%S")
                  fileName="$year-$month-$day-$hour-$minute-$second-$file"
                  backupName="$2/$fileName"
                  cp $file $backupName
 
                  find $2 -type f | wc -l > output.txt
                  size=$(cat output.txt)
 
                  if [ $size -gt $max ]; then
                          oldest="$(ls $2 -lt | grep -v '^d' | tail -1 | awk '{print $NF}')"
                          rm "$backup/$oldest"
                  fi
 
                  /usr/bin/mailx -s "$fileName" $USER < toEmail.txt
                  echo "email sent"
                  else
                  echo "email not sent"
          fi
 
          if [ -e output.txt ]; then
                  rm output.txt
          fi
          if [ -e toEmail.txt ]; then
                  rm toEmail.txt
          fi
 done
