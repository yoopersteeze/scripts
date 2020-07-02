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
# https://www.jamf.com/jamf-nation/discussions/30751/api-script-for-ipad-restart
#	Send a command to iOS device to restart
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
read -p "Mobile Device ID: " deviceID
echo ""

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################

data="<mobile_device_command><general><command>RestartDevice</command></general><mobile_devices><mobile_device><id>${deviceID}</id></mobile_device></mobile_devices></mobile_device_command>"

echo "Attempting to send a RestartDevice command to Mobile Device with ID: $deviceID"
curl -ksu "$username:$password" -H "Content-Type: application/xml" "$server/JSSResource/mobiledevicecommands/command" -d $data -X POST

exit 0
