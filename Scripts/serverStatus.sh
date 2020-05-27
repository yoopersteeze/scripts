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
# POC: Checks the server status when ran. Really this should be used in a LaunchD
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

server="https://server.company.com:8443"
subject="Jamf Pro Server Down"
recipient="foo@company.com"
file="/Users/Shared/jamfProError.txt"

healthStatus=$(curl -m 10 -sk "$server"/healthCheck.html)
if [[ "$healthStatus" != "[]" ]];then
	echo "$healthStatus" >> $file
  cat "$file" | mail -s "$subject" "$recipient"
fi
