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
# This script was designed to touch a file at login

# Make the LaunchAgents directory if does not exist
mkdir -p /Library/LaunchAgents
# Make the Sunnyvale directory if it does not exist
# mkdir -p /Users/Shared/Sunnyvale
# Desired name for plist Example: com.mycompany.test (do not include .plist)
# plistName="$4"
plistName="com.sunnyvale.test1"
# Path to file to touch
# touchFile="$5"
touchFile="/Users/Shared/com.sunnyvale.test1"
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
# Uncomment below for logging
# logFile="/var/log/launchd.log"
# if [ -d "$logFile" ]; then
#   echo "The file /var/log/launchd.log already exists."
# else
#   echo "[WARN] The /var/log/launchd.log did not exit. Creating it now."
#   touch $logFile
# fi
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
  <!--TO ENABLE LOGGING REMOVE THIS LINE AND UNCOMMENT BELOW-->
  <!--key>StandardOutPath</key>
  <string>$logFile</string>
  <key>StandardErrorPath</key>
  <string>$logFile</string>
  <key>Debug</key>
  <true/-->
</dict>
</plist>
EOF
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl load -w "$outputPlist"

exit 0
