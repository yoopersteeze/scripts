#!/bin/bash

username=""
password=""
server=""

echo "Deleting all packages now!"
pkg=$(curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/packages | xmllint --format - | awk -F '[<>]' '/id/{print $3}')
for i in $pkg;do
	curl -ksu $username:$password -H "Content-type: text/xml" $server/JSSResource/packages/id/$i -X DELETE
done
