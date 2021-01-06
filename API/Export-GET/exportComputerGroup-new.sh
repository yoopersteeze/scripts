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
# This script will export a jamf pro computer group  as xml to the Desktop called "Computer-Group-$ID.xml"
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
read -p "Computer Smart Group ID: " id

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
echo "Exporting Computer Group ID: $id to Desktop"
#curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/computergroups/id/$id | xmllint -format - > /Users/"$loggedInUser"/Desktop/Computer-Group-$id.xml
curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/computergroups/id/$id | xmllint --xpath '//computer_group/criteria/criterion' - > /Users/"$loggedInUser"/Desktop/Computer-Group-$id.xml
echo "Done!"
