#!/bin/bash

jcsv=$(defaults read /Applications/Jamf\ Connect\ Sync.app/Contents/Info.plist CFBundleShortVersionString)
file=/Applications/Jamf\ Connect\ Sync.app/Contents/Info.plist
if [[ ! -e $file ]]; then
  echo "<result>Not Installed</result>"
else
echo "<result>$jcsv</result>"
fi
