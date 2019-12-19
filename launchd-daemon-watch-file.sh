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
# Make the LaunchAgents directory if does not exist
# mkdir -p /Library/LaunchDaemons
plistName="com.sunnyvale.login"
# Path to file to touch
# touchFile="$5"
touchFile="/Users/Shared/com.sunnyvale.test1"
event="word"
# outputPlist="/Library/LaunchAgents/$plistName.plist"
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
