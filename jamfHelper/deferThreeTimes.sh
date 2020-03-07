#!/bin/bash
# Credits to github dot come slash zacharyfisher
# Software Update Defer Policy
JAMFHELPER="/Library/Application Support/JAMF/bin/jamfhelper.app/Contents/MacOS/jamfHelper"
log="/var/tmp/su.log"
dt=$(date '+%m/%d/%Y %H:%M:%S')
deferPref=/Library/Preferences/com.sunnyvale.softwareupdate.defer.plist
currentVersion=$(sw_vers | grep ProductVersion | awk '{print $2}')

remaining=$(/usr/bin/defaults read /Library/Preferences/com.sunnyvale.softwareupdate.defer.plist defer)
showJamfHelpers()
{
  "$JAMFHELPER" -windowType utility -windowPosition center -title "macOS Software Update" -heading "macOS Software Update" -alignHeading center -description "You have selected to install this update at a different time.  You have $deferRemaining more deferrals before this update is automatically installed." -alignDescription center -icon /System/Library/PreferencePanes/SoftwareUpdate.prefPane/Contents/Resources/SoftwareUpdate.icns -button1 "Close"
}

#Get User's Selection
RESULT=$("$JAMFHELPER" -windowType utility -windowPosition center -title "macOS Software Update" -heading "macOS Software Update" -alignHeading center -description "This update will install important security updates for your device.  Please save all work, then click Update below to proceed.  This will download and install required updates. " -alignDescription center -icon /System/Library/PreferencePanes/SoftwareUpdate.prefPane/Contents/Resources/SoftwareUpdate.icns -button1 "Update Now" -button2 "Run Later")
if [ "$RESULT" -eq '0' ]; then
  echo "$dt Current macOS Version: $currentVersion"
  echo "$dt Installing updates" >> $log
  rm -rf $deferPref
  /usr/sbin/softwareupdate -i -a -R
elif [ "$RESULT" -eq '2' ]; then
  # Defer Process
  echo "$dt Cancel was pressed!" >> $log
  if [[ ! -e $deferPref ]]; then
    echo "$dt No Plist Found. Creating now!" >> $log
    echo "$dt Current macOS Version: $currentVersion" >> $log
    echo "$dt Cancel hit 1" >> $log
    deferRemaining="3"
    /usr/bin/defaults write $deferPref defer -int 1
    echo "$dt Defers remaining = 3" >> $log
    showJamfHelpers
  elif [[ $remaining -eq '1' ]]; then
    #	elif [[ $deferPrefValue = 1 ]]; then
    echo "$dt Cancel hit 2" >> $log
    /usr/bin/defaults write $deferPref defer -int 2
    echo "$dt Defers remaining = 2" >> $log
    deferRemaining="2"
    showJamfHelpers
  elif [[ $remaining -eq '2' ]]; then
    echo "$dt Cancel hit 3" >> $log
    /usr/bin/defaults write $deferPref defer -int 3
    echo "$dt Defers remaining = 1" >> $log
    deferRemaining="1"
    showJamfHelpers
  elif [[ $remaining -eq '3' ]]; then
    echo "$dt Forcing Install" >> $log
    "$JAMFHELPER" -windowType hud -windowPosition center -title "macOS Software Update" -heading "macOS Software Update" -alignHeading center -description "You have selected to defer this update 3 times and this update will now be installed.  Please save your work immediately." -alignDescription center -icon /System/Library/PreferencePanes/SoftwareUpdate.prefPane/Contents/Resources/SoftwareUpdate.icns -button1 "Close"
    sleep 15
    rm -rf $deferPref
    /usr/sbin/softwareupdate -i -a -R
  fi
fi
