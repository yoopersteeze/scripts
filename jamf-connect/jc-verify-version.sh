#!/bin/bash

jcvv=$(defaults read /Applications/Jamf\ Connect\ Verify.app/Contents/Info.plist CFBundleShortVersionString)
file=/Applications/Jamf\ Connect\ Verify.app/Contents/Info.plist
if [[ ! -e $file ]]; then
  echo "<result>Not Installed</result>"
else
echo "<result>$jcvv</result>"
fi
