#!/bin/bash
# Credits: https://www.jamf.com/jamf-nation/discussions/35366/problem-with-updating-browsers#responseChild200366
APPLICATION="/Applications/Firefox.app"
PROCESS=$(ps aux | grep -v grep | grep -ci "Firefox")
if [ -e "$APPLICATION" ]
then
	echo "$APPLICATION exists."
	if [[ "$PROCESS" -ge "1" ]]
	then
		echo "$APPLICATION is running, exiting."
		exit 0
	else
		echo "$APPLICATION is not running, proceeding with removal."
	fi
else
	echo "$APPLICATION does not exist, exiting."
	exit 0
fi