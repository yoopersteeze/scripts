#!/bin/bash

count="0"

while [ $count -lt 100 ]
do
touch ~/Desktop/file-$count
count=$[$count+1]
sleep 1
done
