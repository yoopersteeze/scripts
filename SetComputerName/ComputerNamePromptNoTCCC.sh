#!/bin/bash

# credits to github dot com slash pirkla
# check that script is run as root user
if [ $EUID -ne 0 ]
then
	>&2 /bin/echo $'\nThis script must be run as the root user!\n'
	exit
fi
# capture user input name
while true
do
		loggedInUser=$(stat -f%Su /dev/console)
		userUID=$(id -u ${loggedInUser})
		name=$(/bin/launchctl asuser "$userUID" sudo -iu "$loggedInUser" /usr/bin/osascript -e 'text returned of (display dialog "Please enter the name for your computer or select Cancel." default answer "")' )
		if [ $? -ne 0 ]
		then # user cancel
				exit 2
		elif [ -z "$name" ]
		then # loop until input or cancel
				/bin/launchctl asuser "$userUID" sudo -iu "$loggedInUser" /usr/bin/osascript -e 'display alert "Please enter a name or select Cancel... Thanks!" as warning'
		else
				break
		fi
done
scutil --set ComputerName $name
scutil --set LocalHostName $name
scutil --set HostName $name
jamf recon
