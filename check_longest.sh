#!/bin/bash

filename=$1
comp_reg_ex=":Completed.*[0-9]*ms.*"
time_regex="[0-9]*ms.*"
max_time=-1
prev=""
cur_prev=""
while read -r line
do
  if [[ $line =~ $comp_reg_ex ]]
    then 
    completion_time=`echo $line | grep -o "[0-9]*ms.*" | sed 's/ms.*//g'`
    if [[ $max_time -lt $completion_time ]]
      then 
      max_time=$completion_time
      cur_prev=$prev
    fi
  fi
  prev=$line
done < "$filename"

echo "Max request time is: "$max_time"ms"
echo "Request is:"
echo $cur_prev | grep -o "Started.*" | sed 's/Started.//g' | sed 's/for.*//g'
