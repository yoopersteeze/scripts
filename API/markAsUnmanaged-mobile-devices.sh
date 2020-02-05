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
# This script can be used to mark mobile devices as unmanaged in Jamf Pro from a list of CSV
# seperated by comma.
# Example:
# 63,
# 64,
# 65,
# 66,
# 67
# The check connection assumes the account has permissions to READ Users.
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Please drag and drop the csv into this window and hit enter: " deviceList

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################
# Courtesy of github dot com slash zdorow
echo "Testing connection to Jamf Pro..."
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
####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################

# Courtesy of github dot com slash iMatthewCM
#Read CSV into array
IFS=$'\n' read -d '' -r -a deviceIDs < $deviceList

length=${#deviceIDs[@]}

#Do all the things
for ((i=0; i<$length;i++));

do
  id=$(echo ${deviceIDs[i]} | sed 's/,//g' | sed 's/ //g'| tr -d '\r\n')
  curl -ksu "$username":"$password" -H "content-type: application/xml" "$server"/JSSResource/mobiledevices/id/$id -X PUT -d "<mobile_device><general><managed>false</managed></general></mobile_device>"
done
