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
# Move Jamf Pro User Accounts to different LDAP Server by ID
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
read -p "User ID to move: " uid
read -p "LDAP Server ID to move user $uid to: " lid

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
echo "Moving UserID $uid to LDAP Server ID $lid"
curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/accounts/userid/$uid -d "<account><ldap_server><id>$lid</id></ldap_server></account>" -X PUT
exit 0
