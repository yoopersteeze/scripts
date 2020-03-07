#!/bin/bash

username="class"
password="class"
server=""



count="0"

# Courtesy of github dot com slash zdorow
echo "Testing connection to Jamf Pro..."
echo "This test assumes the user has READ permissions for Users"
test=$(curl --fail -ksu "$username":"$password" "$server"/JSSResource/users -X GET)
status=$?
if [ $status -eq 6 ]; then
	echo ""
	echo "The Jamf Pro URL is incorrect. Please edit the URL and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 22 ]; then
	echo ""
	echo "Username and/or password is incorrect. Please edit and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 0 ]; then
    echo ""
    echo "Connection test successful! "
    echo ""
else
    echo ""
    echo "Something went really wrong,"
    echo "Lets try this again."
    exit 99
fi

while [ $count -lt 10 ]
do
	curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/classes/id/-1 -d "<class><name>$count</name></class>" -X POST
	count=$[$count+1]
	done
