#!/bin/sh

mouseBatLevel=`ioreg -c AppleDeviceManagementHIDEventService | grep 'Magic Mouse' -A6 | grep BatteryPercent | sed 's/[a-z,A-Z, ,|,\",=]//g' | tail -1 | awk '{print $1}'`
if [[ "${mouseBatLevel}" == "" ]] ; then 
	echo "<result>No Mouse</result>"    
 else
	echo "<result>$mouseBatLevel</result>"
fi
exit 0