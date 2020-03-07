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
# This script was designed create a LaunchDaemon to say "chicken tacos" every 60 second at max volume

# Make the LaunchAgents directory if does not exist
mkdir -p /Library/LaunchDaemons

outputPlist="/Library/LaunchDaemons/com.sunnyvale.chickentacos.plist"

# Turn the volume all the way up
/usr/bin/osascript -e "set Volume 10"

/bin/cat > "$outputPlist" <<EOF
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>EnvironmentVariables</key>
	<dict>
		<key>PATH</key>
		<string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin</string>
	</dict>
	<key>Label</key>
	<string>com.sunnyvale.chickentacos</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/bin/say</string>
		<string>chicken</string>
		<string>tacos</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>60</integer>
</dict>
</plist>
EOF
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl load -w "$outputPlist"

exit 0
