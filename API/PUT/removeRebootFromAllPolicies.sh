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
# Removes restart options from all policies.
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

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################
pID="$(curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/policies | xmllint --format - | awk -F '[<>]' '/id/{print $3}')"
for p in $pID;do
	curl -ksu "$username":"$password" -H "content-type: application/xml" "$server"/JSSResource/policies/id/"$p" -X PUT -d "<policy><reboot><no_user_logged_in>Do not restart</no_user_logged_in><user_logged_in>Do not restart</user_logged_in></reboot></policy>"
done
