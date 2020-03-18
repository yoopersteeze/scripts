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
###################################################################################################
#   Created By: Ryan Peterson
#   Created: Tuesday Sep 18, 2018
#
#   Summary:
#   This script is a method to lock specified Mobile Devices by their JSS_ID
####################################################################################################

username=""
password=""
server=""
id="" #comma seperated with no spaces

curl -ksu $username:$password -H "content-type: text/xml" $server/JSSResource/mobiledevicecommands/command/DeviceLock/id/{$id} -X POST
