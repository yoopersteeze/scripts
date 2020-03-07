#!/bin/bash

fmmStatus=$(defaults read /Library/Preferences/com.apple.FindMyMac.plist FMMEnabled)

if [[ $fmmStatus = "0" ]]; then
echo "<result>Disabled</result>"
else
echo "<result>Enabled</result>"
fi