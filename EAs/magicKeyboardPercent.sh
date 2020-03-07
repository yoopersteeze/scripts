#!/bin/sh
keyboardBatLevel=`ioreg -c AppleDeviceManagementHIDEventService | grep 'Magic Keyboard' -A6 | grep BatteryPercent | sed 's/[a-z,A-Z, ,|,\",=]//g' | tail -1 | awk '{print $1}'`
if [[ "${keyboardBatLevel}" == "" ]] ; then 
	echo "<result>No Keyboard</result>"    
 else
	echo "<result>$keyboardBatLevel</result>"
fi
exit 0