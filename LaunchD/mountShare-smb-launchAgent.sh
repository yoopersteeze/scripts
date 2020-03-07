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
server="$4" # username for share if there is one
share="$5" # password for share if there is one

loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
outputPlist="/Users/$loggedInUser/Library/LaunchAgents/com.smb.launchd.smbshare.plist"
/bin/mkdir -p /Users/"$loggedInUser"/Library/LaunchAgents
####################################################################################################
# Check to see if variables were passed in Jamf Pro
if [ "$4" != "" ] && [ "$server" == "" ]; then
  server=$4
fi

if [ "$5" != "" ] && [ "$share" == "" ]; then
  share=$5
fi

####################################################################################################
/bin/echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.smb.launchd.smbshare</string>
    <key>ProgramArguments</key>
    <array>
      <string>open</string>
      <string>smb://'$server'/'$share'</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>' >> "$outputPlist"
####################################################################################################
/usr/sbin/chown -R root:wheel $outputPlist
/bin/chmod 644 $outputPlist
/bin/launchctl load -w "$outputPlist"
