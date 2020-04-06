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
#
# DESCRIPTION
# Proof of concept to prompt user to quit an app if process is found running for use with policy
#	
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

SERVICE='Google Chrome'
title="Patch Management"
message="Please quit Google Chrome"
# Show message with Notification Center
showMessage=$('/Library/Application Support/JAMF/bin/Management Action.app/Contents/MacOS/Management Action' -title "$title" -message "$message")
# jamfHelper show message
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
# window position (ul | ur | ll | lr)
windowPosition="ll"
# Title text for the notification, example would be Company Name
titleText="Patch Management or something"
# Custom heading text to display
headingText="Update required"
# Description that will appear to the end user
descriptionText="Please quit $SERVICE to apply necessary update"
# Enter a path to an icon to display. Example below will display the App Store icon
iconLocation="/Applications/Google Chrome.app/Contents/Resources/app.icns"


####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################

if pgrep -xq -- "${SERVICE}"; then
	echo "running"
	$showMessage
	"$jamfHelper" -windowType hud -windowPosition "$windowPosition" -title "$titleText" -description "$descriptionText" -icon "$iconLocation" -heading "$headingText"
else
	echo "not running"
fi