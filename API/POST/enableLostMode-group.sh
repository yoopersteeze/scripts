#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Copyright (c) 2018 Jamf.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the Jamf nor the names of its contributors may be
#                 used to endorse or promote products derived from this software without
#                 specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This script was created to be able to issue a EnableLostMode command in mass to all
# supervised devices within the specified Mobile Device Group.
#
# REQUIREMENTS:
#			- Jamf Pro
#			- Local Jamf Pro user with appropriate permissions
#
#
# Written by: Joshua Roskos | Jamf
#
# Created On: June 11th, 2018
# Updated On: June 11th, 2018
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

jamfProURL="https://acme.jamfcloud.com"             # URL of the Jamf Pro server (ie. https://jamf.acme.com:8443)
jamfUser=""					                    	# API user account in Jamf Pro w/ Update permission
jamfPass=""					                    	# Password for above API user account
mobileDeviceGroupID=""                              # ID Number of Mobile Device Group to Enable Lost Mode for
lostModeMsg=""                                      # Lost Message to Display on Lock Screen
lostModePhone=""                                    # Phone Number to Display on Lock Screen

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APPLICATION
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

deviceIDs=( $( curl -k -s -u "$jamfUser":"$jamfPass" $jamfProURL/JSSResource/mobiledevicegroups/id/$mobileDeviceGroupID -H "Accept: application/xml" -X GET | xpath "//mobile_device_group/mobile_devices" | /usr/bin/perl -lne 'BEGIN{undef $/} while (/<id>(.*?)<\/id>/sg){print $1}' ) )

for i in ${deviceIDs[@]}; do
    echo "Sending EnableLostMode Command to Device ID: $i..."
    /usr/bin/curl -sk -u "$jamfUser":"$jamfPass" -H "Content-Type: text/xml" -d "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><mobile_device_command><general><command>EnableLostMode</command><lost_mode_message>$lostModeMsg</lost_mode_message><lost_mode_phone>$lostModePhone</lost_mode_phone></general><mobile_devices><mobile_device><id>$i</id></mobile_device></mobile_devices></mobile_device_command>" $jamfProURL/JSSResource/mobiledevicecommands/command/EnableLostMode -X POST > /dev/null
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
