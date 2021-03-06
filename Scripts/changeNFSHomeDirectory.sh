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
# For examples assume the loggedInUser is literally: jamf.admin
####################################################################################################
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# find old directory
oldDir=$(dscl . -read /Users/$loggedInUser NFSHomeDirectory | awk '{print $2}')
echo "Old Dir: $oldDir"

# set new directory
newDir=""
# Check if $newDir is blank
if [[ -z "$newDir"]]; then
  echo "\$newDir is null, please set a value. Exiting script as failure."
  exit 1
fi
echo "New Dir: $newDir"

# change it
dscl . -change /Users/"$loggedInUser" NFSHomeDirectory "$oldDir" "$newDir"

####################################################################################################
# Example
#newDir="/Users/$loggedInUser/Desktop

# syntax below
#dscl . -change /Users/<username> NFSHomeDirectory <old-path> <new-path>
# Exmaple to change home directory to /Users/jamf.admin/Desktop
# dscl . -change /Users/"$loggedInUser" NFSHomeDirectory "$oldDir" "$newDir"
