#!/bin/bash

jclv=$(defaults read /Library/Security/SecurityAgentPlugins/JamfConnectLogin.bundle/Contents/Info.plist CFBundleShortVersionString)
file="/Library/Security/SecurityAgentPlugins/JamfConnectLogin.bundle"
if [[ ! -e $file ]]; then
  echo "<result>Not Installed</result>"
else
echo "<result>$jclv</result>"
fi
