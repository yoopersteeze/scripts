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

# get logged in user
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# bail out if user is null, root or _mbsetupser or other local user specified
if [[ -z "$loggedInUser" || "$loggedInUser" == "root" || "$loggedInUser" == "_mbsetupser" || "$loggedInUser" == "ldamin" ||  "$loggedInUser" == "mysuperuser" ]]; then
  echo "No real user logged in"
  echo "Logged in user is: $loggedInUser"
  exit 1
else
  echo "Proceeding"
fi

# get ID of logged in user
uid=$(dscl . read /Users/"$loggedInUser" UniqueID | awk '{print $2}')

# make the User's LaunchAgents directory if it does not exist
/bin/mkdir -p /Users/"$loggedInUser"/Library/LaunchAgents

# Parameter 4 in Jamf Pro
plistName="$4"

# Parameter 5 in Jamf Pro
appPath="$5"

# Error checking
if [ -z "$plistName" ]; then
  echo "\$plistName is null, please set a value. Exiting script."
  exit 1
else
  echo "\$plistName is set to: $plistName"
fi
if [ -z "$appPath" ]; then
  echo "\$appPath is null, please set a value. Exiting script."
  exit 1
else
  echo "\$appPath is set to: $appPath"
fi

# Output plist file name
outputPlist="/Users/$loggedInUser/Library/LaunchAgents/$plistName.plist"

# make the LaunchAgent
/bin/cat > "$outputPlist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$plistName</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/open</string>
    <string>$appPath</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
EOF

# Set Permissions and load
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl bootstrap gui/"$uid" "$outputPlist"

exit 0
