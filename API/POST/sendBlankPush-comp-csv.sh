#!/bin/bash

####################################################################################################
#
# THIS SCRIPT IS NOT AN OFFICIAL PRODUCT OF JAMF SOFTWARE
# AS SUCH IT IS PROVIDED WITHOUT WARRANTY OR SUPPORT
#
# BY USING THIS SCRIPT, YOU AGREE THAT JAMF SOFTWARE
# IS UNDER NO OBLIGATION TO SUPPORT, DEBUG, OR OTHERWISE
# MAINTAIN THIS SCRIPT
#
####################################################################################################
#
# This script will read in .csv of computer IDs and send blank push to those IDs
####################################################################################################
read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Please drag and drop the csv into this window and hit enter: " groupList

# Courtesy of github dot com slash iMatthewCM
# Read CSV into array
IFS=$'\n' read -d '' -r -a groupsIDs < $groupList

length=${#groupsIDs[@]}

#Do all the things
for ((i=0; i<$length;i++));

do
	id=$(echo ${groupsIDs[i]} | sed 's/,//g' | sed 's/ //g'| tr -d '\r\n')
	echo "Sending BlankPush Command to Device ID: $id..."
	/usr/bin/curl -s -u "$username":"$password" -H "Content-Type: text/xml" "$server"/JSSResource/computercommands/command/BlankPush/id/"$id" -X POST
done
