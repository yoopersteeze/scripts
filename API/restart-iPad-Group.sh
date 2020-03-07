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
# This script will send a command to restart ipad to desired mobile device group
# Most credits go to github dot com slash kc9wwh
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

jamfProURL="https://acme.jamfcloud.com"             # URL of the Jamf Pro server (ie. https://jamf.acme.com:8443)
jamfUser=""					                    	# API user account in Jamf Pro w/ Update permission
jamfPass=""					                    	# Password for above API user account
mobileDeviceGroupID=""                              # ID Number of Mobile Device Group to Enable Lost Mode for

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APPLICATION
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

deviceIDs=( $( curl -k -s -u "$jamfUser":"$jamfPass" $jamfProURL/JSSResource/mobiledevicegroups/id/$mobileDeviceGroupID -H "Accept: application/xml" -X GET | xpath "//mobile_device_group/mobile_devices" | /usr/bin/perl -lne 'BEGIN{undef $/} while (/<id>(.*?)<\/id>/sg){print $1}' ) )

for i in ${deviceIDs[@]}; do
    echo "Sending Restart Command to Device ID: $i..."
    /usr/bin/curl -sk -u "$jamfUser":"$jamfPass" -H "Content-Type: text/xml" -d "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><mobile_device_command><general><command>RestartDevice</command>></general><mobile_devices><mobile_device><id>$i</id></mobile_device></mobile_devices></mobile_device_command>" $jamfProURL/JSSResource/mobiledevicecommands/command/RestartDevice -X POST > /dev/null
    if [[ "$?" == "0" ]]; then
        echo "   Command Processed Successfully"
    else
        echo "   Error Processing Command"
    fi
    echo ""
done


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# CLEANUP & EXIT
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

exit 0
