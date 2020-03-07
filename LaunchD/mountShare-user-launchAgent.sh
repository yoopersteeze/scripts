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
# This will make a User lauch agent to mount a SMB share at login. Alternatively it can be
# used to mount a AFP share if so desired.
####################################################################################################
username="$4" # username for share if there is one
password="$5" # password for share if there is one
server="$6" # hostname or IP of server share is on
share="$7" # name of share to mount
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
outputPlist="/Users/$loggedInUser/Library/LaunchAgents/com.smb.launchd.smbshare.plist"
/bin/mkdir -p /Users/"$loggedInUser"/Library/LaunchAgents
####################################################################################################
# Check to see if variables were passed in Jamf Pro
if [ "$4" != "" ] && [ "$username" == "" ]; then
  username=$4
fi

if [ "$5" != "" ] && [ "$password" == "" ]; then
  password=$5
fi

if [ "$6" != "" ] && [ "$server" == "" ]; then
  server=$6
fi

if [ "$7" != "" ] && [ "$share" == "" ]; then
  share=$7
fi
####################################################################################################
/bin/echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.smb.launched.smbshare</string>
    <key>ProgramArguments</key>
    <array>
      <string>open</string>
      <string>smb://'$username':'$password'@'$server'/'$share'</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>' >> "$outputPlist"
####################################################################################################
/usr/sbin/chown -R root:wheel $outputPlist
/bin/chmod 644 $outputPlist
/bin/launchctl load -w "$outputPlist"
