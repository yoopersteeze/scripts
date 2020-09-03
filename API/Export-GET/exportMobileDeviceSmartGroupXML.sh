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
# This script will export a mobile device group as xml to the Desktop called "Mobile-Device-Group-Name-"$name".xml"
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
read -p "Mobile Device SmartGroup ID: " id

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
# Get the name of the group
name=$(curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/mobiledevicegroups/id/$id | xmllint --xpath '/mobile_device_group/name/text()' -)
# export to Desktop
echo "Exporting Mobile Device SmartGroup ID: $id - Name: $name to Desktop"
curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/mobiledevicegroups/id/$id | xmllint -format - > ~/Desktop/Mobile-Device-Group-Name-"$name".xml
echo "Done!"
