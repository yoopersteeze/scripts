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
# This script was designed to touch a file at login to be used with a launchd to execute a jamf policy at login

# Make the LaunchAgents directory if does not exist
mkdir -p /Library/LaunchAgents
# Desired name for plist Example: com.mycompany.test (do not include .plist)
# plistName="$4"
plistName="com.company.something.meaningful"
# Path to file to touch
# touchFile="$5"
touchFile="/Users/Shared/com.company.something.meaningful"
# Error checking
if [ -z "$plistName" ]; then
  echo "\$plistName is null, please set a value. Exiting script."
  exit 1
else
  echo "\$plistName is set to: $plistName"
fi
if [ -z "$touchFile" ]; then
  echo "\$touchFile is null, please set a value. Exiting script."
  exit 1
else
  echo "\$touchFile is set to: $touchFile"
fi
outputPlist="/Library/LaunchAgents/$plistName.plist"
/bin/cat > "$outputPlist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$plistName</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/touch</string>
    <string>$touchFile</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl load -w "$outputPlist"

exit 0
