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
#
#	Send a command to iOS device to enable Lost Mode
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Mobile Device ID: " deviceID
read -p "Lost Mode Message: " lostModeMsg
read -p "Lost Mode Phone: " lostModePhone
echo ""

####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################
# Courtesy of github dot com slash zdorow
echo "Testing connection to Jamf Pro..."
test=$(curl --fail -ksu "$username":"$password" "$server"/JSSResource/users -X GET)
status=$?
if [ $status -eq 6 ]; then
	echo ""
	echo "The Jamf Pro URL is incorrect. Please edit the URL and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 22 ]; then
	echo ""
	echo "Username and/or password is incorrect. Please edit and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 0 ]; then
    echo ""
    echo "Connection test successful! "
    echo ""
else
    echo ""
    echo "Something went really wrong,"
    echo "Lets try this again."
    exit 99
fi
####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
data="<mobile_device_command><general><lost_mode_message>"$lostModeMsg"</lost_mode_message><lost_mode_phone>"$lostModePhone"</lost_mode_phone><always_enforce_lost_mode>true</always_enforce_lost_mode><disallow_proximity_setup>true</disallow_proximity_setup><lost_mode_with_sound>false</lost_mode_with_sound></general><mobile_devices><mobile_device><id>${deviceID}</id></mobile_device></mobile_devices></mobile_device_command>"

echo "Attempting to send a Lost Mode command to Mobile Device with ID: $deviceID"
curl -ksu "$username:$password" -H "content-type: application/xml" "$server/JSSResource/mobiledevicecommands/command/EnableLostMode" -d "$data" -X POST

exit 0
