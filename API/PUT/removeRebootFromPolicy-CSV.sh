#!/bin/sh
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
# Remove Reboot Payload from CSV list of policy IDS
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
read -p "Please drag and drop the csv into this window and hit enter: " policyList

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

# Courtesy of github dot com slash iMatthewCM
#Read CSV into array
IFS=$'\n' read -d '' -r -a policyIDs < $policyList

length=${#policyIDs[@]}

#Do all the things
for ((i=0; i<$length;i++));

do
  id=$(echo ${policyIDs[i]} | sed 's/,//g' | sed 's/ //g'| tr -d '\r\n')
  curl -ksu "$username":"$password" -H "content-type: application/xml" "$server"/JSSResource/policies/id/"$id" -X PUT -d "<policy><reboot><no_user_logged_in>Do not restart</no_user_logged_in><user_logged_in>Do not restart</user_logged_in></reboot></policy>"
done
