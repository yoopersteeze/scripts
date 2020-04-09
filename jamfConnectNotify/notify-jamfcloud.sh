#!/bin/bash

###
### Do it!
###
NOTIFY_LOG="/var/tmp/depnotify.log"


# Set a main image
echo "Command: Image: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbookpro-15-retina-touchid-space-gray.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Welcome To Jamfcloud!" >> $NOTIFY_LOG
echo "Command: MainText: Welcome to your new Mac.\\nWe are setting up a few things for you automatically.\\nPlease feel free to grab a coffee as this may take 10-15 minutes!" >> $NOTIFY_LOG
sleep 10
echo "Status: Preparing your new machine" >> $NOTIFY_LOG
echo "Command: Determinate: 15" >> $NOTIFY_LOG
sleep 2
echo "Status: Reticulating splines..." >> $NOTIFY_LOG
sleep 2
###
### Jamf Triggers
###

echo "Status: Aligning quantums..." >> $NOTIFY_LOG

sleep 5
echo "Command: Image: /System/Library/CoreServices/Install in Progress.app/Contents/Resources/Installer.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing everything you need for your first day" >> $NOTIFY_LOG
echo "Command: MainText: All the apps you'll need today are already being installed. Once we're ready to start, you'll find Google Chrome and Firefox are all ready to go!\\nUse Spotlight search (Command + Spacebar) and type the app you want to open!" >> $NOTIFY_LOG
###
sleep 10
echo "Command: Image: /usr/local/images/ss.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Self Service makes the Mac life easier" >> $NOTIFY_LOG
echo "Command: MainText: Self Service includes helpful bookmarks and installers for other applications that may interest you." >> $NOTIFY_LOG
###
sleep 10
###
echo "Command: Image: /usr/local/images/chrome.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing Google Chrome" >> $NOTIFY_LOG
echo "Command: MainText: Chrome is the worlds most powerful browser, but we'll install Firefox for you too!" >> $NOTIFY_LOG
echo "Status: Installing Chrome..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event install-chrome
###
echo "Command: Image: /usr/local/images/firefox.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: See! Told you!" >> $NOTIFY_LOG
echo "Command: MainText: We'd prefer if you use Chrome, but Firefox is here in case you need it." >> $NOTIFY_LOG
echo "Status: Installing Firefox..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event firefox
###
echo "Command: Image: /usr/local/images/firefox.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Dock Time!" >> $NOTIFY_LOG
echo "Command: MainText: We're setting the Dock for you with the apps you'll need right away!" >> $NOTIFY_LOG
echo "Status: Installing Firefox..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event dockutil

###
### Clean Up
###

sleep 3
echo "Command: Quit" >> $NOTIFY_LOG

sleep 1
echo "setup done" >> /var/tmp/notifydone
rm -rf $NOTIFY_LOG

/usr/local/bin/authchanger -reset -Okta
