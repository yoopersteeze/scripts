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
# plistName="$4"
# plist domain name that is meaningful
plistName="com.company.something.meaningful"
# Path to file to touch
# touchFile="$5"
touchFile="/Users/Shared/com.company.something.meaningful" # This is the same file the launch agent is touching
event="word"
# event="$6"
outputPlist="/Library/LaunchDaemons/$plistName.plist"
/bin/cat > "$outputPlist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$plistName</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/bin/jamf</string>
		<string>policy</string>
		<string>-event</string>
		<string>$event</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>WatchPaths</key>
	<array>
		<string>$touchFile</string>
	</array>
</dict>
</plist>
EOF
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl load -w "$outputPlist"
exit 0
