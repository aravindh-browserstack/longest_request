#!/bin/bash

filename=$1
comp_reg_ex=":Completed.*[0-9]*ms.*"
time_regex="[0-9]*ms.*"
line_num=1
max_time=-1
max_line_num=-1
while read -r line
do
  if [[ $line =~ $comp_reg_ex ]]
    then 
    completion_time=`echo $line | grep -o "[0-9]*ms.*" | sed 's/ms.*//g'`
    if [[ $max_time -lt $completion_time ]]
      then 
      max_time=$completion_time
      max_line_num=$line_num
    fi
  fi
  line_num=$[$line_num + 1]
done < "$filename"

echo "Max request time is: "$max_time
echo "Request is:"
prev_line=$[$max_line_num - 1]
sed -n "$prev_line,${max_line_num}p" $filename
