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

#Curl the download for Slack
curl https://downloads.slack-edge.com/mac_releases/Slack-4.1.2-macOS.dmg -o /tmp/slack.dmg

#Mount the installer
hdiutil attach -nobrowse -quiet /tmp/slack.dmg
#
##Copy the app to /Applications
cp -r /Volumes/Slack.app/Slack.app /Applications/
#
##Unmount the DMG
hdiutil detach -quiet /Volumes/Slack.app/
#
##Clean up
rm /tmp/slack.dmg
