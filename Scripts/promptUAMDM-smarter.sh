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

# Get Help = /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -help
# Variables below can also be set to use script parameters: https://www.jamf.com/jamf-nation/articles/146/script-parameters
# Path to jamfHelper
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
# window position (ul | ur | ll | lr)
windowPosition="ll"
# Title text for the notification, example would be Company Name
titleText="Acme Soft"
# Custom heading text to display
headingText="Action Needed"
# Description that will appear to the end user
descriptionText="Due to updated security requirements at Acme Soft please approve your MDM Profile"
# Enter a path to an icon to display. Example below will display the App Store icon
iconLocation="/System/Library/PreferencePanes/Profiles.prefPane/Contents/Resources/Profiles.icns"
# Timeout in seconds
#timeout="5"

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

userChoice=$("$jamfHelper" -windowType hud -windowPosition "$windowPosition" -defaultButton "1" -button1 "Ok" -title "$titleText" -description "$descriptionText" -icon "$iconLocation" -heading "$headingText")

if [[ "$userChoice" == "0" ]]; then
	open /System/Library/PreferencePanes/Profiles.prefPane
fi


