#!/bin/bash

#Curl the download for Firefox
curl https://download-installer.cdn.mozilla.net/pub/firefox/releases/59.0/mac/en-US/Firefox%2059.0.dmg -o /tmp/firefox.dmg

#Mount the installer
hdiutil attach -nobrowse -quiet /tmp/firefox.dmg
#
##Copy the app to /Applications
cp -r /Volumes/Firefox/Firefox.app /Applications/
#
##Unmount the DMG
hdiutil detach -quiet /Volumes/Firefox/
#
##Clean up
rm /tmp/firefox.dmg
