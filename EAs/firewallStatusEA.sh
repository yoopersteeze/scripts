#!/bin/bash

check=$( /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate | awk '{print $3}' | sed 's/\.//g' )

if [ "$check" == 'disabled' ];
then
	echo "<result>Disabled</result>"
else
	echo "<result>Enabled</result>"
fi