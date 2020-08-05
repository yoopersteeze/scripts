#!/bin/bash

RESULT=$( /usr/libexec/mdmclient QueryDeviceInformation | grep IsSupervised | head -1 | sed 's/^ *//g' | awk '{print $3}' | sed 's/.$//' )

majorOSVersion=$(/usr/bin/sw_vers -productVersion | awk -F. {'print $2'})

if [[ $majorOSVersion -lt 15 ]]; then
	echo "<result>Collected for 10.15 or later</result>"
elif
	[[ $RESULT -eq 0 ]]; then
	echo "<result>No</result>"
else
	echo "<result>Yes</result>"
fi