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
# This script will use the classic API to get the assigned username in jamf pro of a computer
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

username="$4"
password="$5"
server="$6"

sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
id=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/computers/serialnumber/$sn | xmllint --xpath "computer/general/id/text()" -)

user=$(curl -ksu "$username":"$password" -H "Accept: application/xml" "$server"/JSSResource/computers/id/"$id" | xmllint --xpath '/computer/location/username/text()' - )

echo "Assigned Username in Jamf Pro is: $user"
