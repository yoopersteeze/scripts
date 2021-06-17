#!/bin/bash
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Copyright (c) 2021 Jamf.  All rights reserved.
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
# VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

jamfProURL=""
jamfUser=""					# READ & DELETE on Mobile Device, READ on Advanced Mobile Device Searches, [x] Send Mobile Device Remote Wipe Command
jamfPass=""
mobileDeviceSearchID=""

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APPLICATION
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

deviceIDs=$( curl -s -u "$jamfUser":"$jamfPass" "$jamfProURL"/JSSResource/advancedmobiledevicesearches/id/"$mobileDeviceSearchID" -X GET | /usr/bin/xpath -q -e "//advanced_mobile_device_search/mobile_devices/mobile_device/id/text()" )

for i in ${deviceIDs[@]}; do
  echo "Sending EraseDevice Command to Device ID: $i..."
  /usr/bin/curl -s -u "$jamfUser":"$jamfPass" -H "Content-Type: text/xml" -d "<mobile_device_command><general><command>EraseDevice</command></general><mobile_devices><mobile_device><id>${i}</id></mobile_device></mobile_devices></mobile_device_command>" $jamfProURL/JSSResource/mobiledevicecommands/command/EraseDevice -X POST > /dev/null
  sleep 5
  if [[ "$?" == "0" ]]; then
    echo "   Command Processed Successfully"
  else
    echo "   Error Processing Command"
  fi
  echo ""
done
