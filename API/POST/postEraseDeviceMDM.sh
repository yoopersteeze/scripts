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
