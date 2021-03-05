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
# DESCRIPTION
# Read in CSV of computers and echo if managed
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Please drag and drop the csv into this window and hit enter: " computerList

####################################################################################################

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

# Courtesy of github dot com slash iMatthewCM
#Read CSV into array
IFS=$'\n' read -d '' -r -a computerIDs < $computerList

length=${#computerIDs[@]}

#Do all the things
for ((i=0; i<$length;i++));

do
	id=$(echo ${computerIDs[i]} | sed 's/,//g' | sed 's/ //g'| tr -d '\r\n')
	managed=$(curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/id/"$id" | xmllint --xpath '/computer/general/remote_management/managed/text()' - )
	mdm=$(curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/id/"$id" | xmllint --xpath '/computer/general/mdm_capable/text()' - )
	echo "ID $id is:
	Managed: $managed
	MDM Capable: $mdm"
done
