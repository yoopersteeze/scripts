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
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
# Make the LaunchAgents directory if does not exist
/bin/mkdir -p /Users/"$loggedInUser"/Library/LaunchAgents
# Desired name for plist Example: com.mycompany.test (do not include .plist)
plistName="$4"
# Path to script
scriptPath="$5"
# scriptPath=""
if [ -z "$plistName" ]; then
  echo "\$plistName is null, please set a value. Exiting script."
  exit 1
else
  echo "\$plistName is set to: $plistName"
fi
if [ -z "$scriptPath" ]; then
  echo "\$scriptPath is null, please set a value. Exiting script."
  exit 1
else
  echo "\$scriptPath is set to: $scriptPath"
fi
outputPlist="/Users/$loggedInUser/Library/LaunchAgents/$plistName.plist"
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
  <string>'$plistName'</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>'$scriptPath'</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
  <!--TO ENABLE LOGGING REMOVE THIS LINE AND UNCOMMENT BELOW-->
  <!--key>StandardOutPath</key>
  <string>'$logFile'</string>
  <key>StandardErrorPath</key>
  <string>'$logFile'</string>
  <key>Debug</key>
  <true/-->
</dict>
</plist>
EOF

/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl bootstrap system "$outputPlist"
exit 0
