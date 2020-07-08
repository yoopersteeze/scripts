#!/bin/bash

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
# Disable all policies in Jamf Pro
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
# MAIN PROCESS
#
####################################################################################################
echo "Disabling all policies..."
policyID=$(curl -ksu $username:$password -H "accept: text/xml" $server/JSSResource/policies | xmllint --format - | awk -F '[<>]' '/id/{print $3}')
for id in $policyID;do
	curl -ksu $username:$password -H "Content-type: application/xml" $server/JSSResource/policies/id/$id -X PUT -d '<policy><general><enabled>false</enabled></general></policy>'
done
