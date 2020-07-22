#!/bin/bash
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
# Get Help = /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -help
# Variables below can also be set to use script parameters: https://www.jamf.com/jamf-nation/articles/146/script-parameters
# Path to jamfHelper
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
# window position (ul | ur | ll | lr)
windowPosition="ll"
# Title text for the notification, example would be Company Name
titleText="Password out of date"
# Custom heading text to display
headingText=""
# Description that will appear to the end user
descriptionText="Your local Mac password does not match Okta. Please click OK to sign into Jamf Connect Sync."
# Enter a path to an icon to display. Example below will display the App Store icon
iconLocation="/Applications/Jamf Connect Sync.app/Contents/Resources/AppIcon.icns"
# Timeout in seconds
timeout=""

# Check to see if variables were passed in Jamf Pro
if [ "$4" != "" ] && [ "$windowPosition" == "" ]; then
	windowPosition=$4
fi

if [ "$5" != "" ] && [ "$titleText" == "" ]; then
	titleText=$5
fi

if [ "$6" != "" ] && [ "$headingText" == "" ]; then
	headingText=$6
fi

if [ "$7" != "" ] && [ "$descriptionText" == "" ]; then
	descriptionText=$7
fi

if [ "$8" != "" ] && [ "$iconLocation" == "" ]; then
	iconLocation=$8
fi

if [ "$9" != "" ] && [ "$timeout" == "" ]; then
	timeout=$9
fi


buttonClicked=$( "$jamfHelper" -windowType hud -windowPosition "$windowPosition" -defaultButton "1" -button1 "Ok" -title "$titleText" -description "$descriptionText" -icon "$iconLocation" -heading "$headingText")

if [[ "$buttonClicked" = "0" ]];then
	su "$loggedInUser" -c "open jamfconnectsync://signin"
fi
