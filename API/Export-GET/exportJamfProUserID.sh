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
# This script will export a jamf pro user  as xml to the Desktop called "Jamf-Pro-User-$ID.xml"
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
read -p "Jamf Pro User Account ID: " id
####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
echo "Exporting Jamf Pro User ID: $id to Desktop"
curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/accounts/userid/$id | xmllint -format - > /Users/"$loggedInUser"/Desktop/Jamf-Pro-User-$id.xml
echo "Done!"
