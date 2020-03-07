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
# plist domain name that is meaningful
#plistName="$4"
plistName="com.sunnyvale.chrome.watcher"
outputPlist="/Library/LaunchDaemons/$plistName.plist"
/bin/cat > "$outputPlist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.sunnyvale.chrome.watcher</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/bin/jamf</string>
		<string>runScript</string>
		<string>-script</string>
		<string>chrome-watcher.sh</string>
		<string>-path</string>
		<string>/Library/Scripts/SunnyvaleScripts/</string>
	</array>
  <key>StartInterval</key>
	<integer>300</integer>
	<key>UserName</key>
	<string>root</string>
</dict>
</plist>
EOF
/usr/sbin/chown -R root:wheel "$outputPlist"
/bin/chmod 644 "$outputPlist"
/bin/launchctl load -w "$outputPlist"
exit 0
