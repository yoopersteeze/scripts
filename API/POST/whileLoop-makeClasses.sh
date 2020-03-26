#!/bin/bash

username="class"
password="class"
server=""

count="0"

while [ $count -lt 10 ]
do
  curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/classes/id/-1 -d "<class><name>$count</name></class>" -X POST
  count=$[$count+1]
done
