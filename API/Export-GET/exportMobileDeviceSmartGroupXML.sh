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
# This script will export a saved search as xml to the Desktop called "Saved-Search-$ID.xml"
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
echo "Exporting SmartGroup ID: $id to Desktop"
curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/mobiledevicegroups/id/$id | xmllint -format - > ~/Desktop/Mobile-Device-Group-$id.xml
echo "Done!"