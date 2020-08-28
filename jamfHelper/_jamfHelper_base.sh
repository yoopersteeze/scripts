#!/bin/bash

# Get Help = /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -help
# Variables below can also be set to use script parameters: https://www.jamf.com/jamf-nation/articles/146/script-parameters
# Path to jamfHelper
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
# window position (ul | ur | ll | lr)
windowPosition=""
# Title text for the notification, example would be Company Name
titleText=""
# Custom heading text to display
headingText=""
# Description that will appear to the end user
descriptionText=""
# Enter a path to an icon to display. Example below will display the App Store icon
iconLocation="/System/Library/PreferencePanes/AppStore.prefPane/Contents/Resources/appStore.icns"
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

userChoice=$("$jamfHelper" -windowType hud -windowPosition "$windowPosition" -defaultButton "1" -button1 "Ok" -button2 "Cancel" -title "$titleText" -description "$descriptionText" -icon "$iconLocation" -heading "$headingText")

# If user selects "Update Now"
if [ "$userChoice" -eq 0 ]; then
   /usr/local/bin/jamf policy -event customTriggerNameHere
# If user selects "Later"
elif [ "$userChoice" -eq 2 ]; then
   echo "User clicked Later; now exiting."
   exit 0
fi
