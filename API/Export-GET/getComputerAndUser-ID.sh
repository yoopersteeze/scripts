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
# Read in paramters to get computer by ID and user by ID
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
read -p "Computer ID to get: " cid
read -p "User ID to get: " uid
####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################
# get computer
curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/id/"$cid" | xmllint --format - > ~/Downloads/"$cid.xml"

# get user
curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/users/id/"$uid" | xmllint --format - > ~/Downloads/"$uid.xml"
