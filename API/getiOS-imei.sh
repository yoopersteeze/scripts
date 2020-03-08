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
# This script will read in parameters, and attempt to grab the IMEI for the device (if applicable)
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Mobile Device ID: " did

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################
imei=$(curl -ksu $username:$password -H "accept: application/xml" $server/JSSResource/mobiledevices/id/$did | xmllint --xpath "mobile_device/network/imei/text()" - )

echo "The IMEI is: $imei"
