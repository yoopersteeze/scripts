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
# Credits to github dot com slash zacharyfisher
#####################################
# Set Variables
#####################################
deferPref=/Library/Preferences/com.company.softwareupdate.defer.plist
title="macOS Software Update"
heading="ACME Soft LLC"
description="This update will install important security updates for your device.  Please save all work, then click Update below to proceed.  This will download and install required updates."
icon="/System/Library/PreferencePanes/SoftwareUpdate.prefPane/Contents/Resources/SoftwareUpdate.icns"
#####################################
# Path to Jamf Helper
JAMFHELPER="/Library/Application Support/JAMF/bin/jamfhelper.app/Contents/MacOS/jamfHelper"
#####################################
# Log File
log="/var/tmp/su.log"
#####################################
# Current macOS Version
currentVersion=$(sw_vers | grep ProductVersion | awk '{print $2}')
#####################################
showJamfHelpers()
{
  "$JAMFHELPER" -windowType utility -windowPosition center -title "$title" -heading "$heading" -alignHeading center -description "You have selected to install this update at a different time.  You have $deferRemaining more deferrals before this update is automatically installed." -alignDescription center -icon "$icon" -button1 "Close"
}
#####################################
#Get User's Selection
RESULT=$("$JAMFHELPER" -windowType utility -windowPosition center -title "$title" -heading "$heading" -alignHeading center -description "$description" -alignDescription center -icon "$icon" -button1 "Update Now" -button2 "Run Later")
if [ "$RESULT" -eq '0' ]; then
  echo "$(date) Current macOS Version: $currentVersion"
  echo "$(date) Installing updates" >> $log
  rm -rf $deferPref
  /usr/sbin/softwareupdate -i -a -R
elif [ "$RESULT" -eq '2' ]; then
  # Defer Process
  echo "$(date) Cancel was pressed!" >> $log
  if [[ ! -e $deferPref ]]; then
    echo "$(date) No Plist Found. Creating now!" >> $log
    echo "$(date) Current macOS Version: $currentVersion" >> $log
    echo "$(date) Cancel hit 1" >> $log
    deferRemaining="3"
    /usr/bin/defaults write $deferPref defer -int 1
    echo "$(date) Defers left = 3" >> $log
    showJamfHelpers
  elif [[ $(/usr/bin/defaults read $deferPref defer) -eq '1' ]]; then
    #	elif [[ $deferPrefValue = 1 ]]; then
    echo "$(date) Cancel hit 2" >> $log
    /usr/bin/defaults write $deferPref defer -int 2
    echo "$(date) Defers left = 2" >> $log
    deferRemaining="2"
    showJamfHelpers
  elif [[ $(/usr/bin/defaults read $deferPref defer) -eq '2' ]]; then
    echo "$(date) Cancel hit 3" >> $log
    /usr/bin/defaults write $deferPref defer -int 3
    echo "$(date) Defers left = 1" >> $log
    deferRemaining="1"
    showJamfHelpers
  elif [[ $(/usr/bin/defaults read $deferPref defer) -eq '3' ]]; then
    echo "$(date) Forcing Install" >> $log
    "$JAMFHELPER" -windowType hud -windowPosition center -title "$title" -heading "$heading" -alignHeading center -description "You have selected to defer this update 3 times and this update will now be installed.  Please save your work immediately." -alignDescription center -icon "$icon" -button1 "Close"
    sleep 15
    rm -rf $deferPref
    /usr/sbin/softwareupdate -i -a -R
  fi
fi
