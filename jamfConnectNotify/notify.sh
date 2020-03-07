#!/bin/bash

###
### Do it!
###
NOTIFY_LOG="/var/tmp/depnotify.log"


# Set a main image
echo "Command: Image: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbookpro-15-retina-touchid-space-gray.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Welcome To Sunnyvale Trailer Park!" >> $NOTIFY_LOG
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
echo "Command: MainText: All the apps you'll need today are already being installed. Once we're ready to start, you'll find Google Chrome, Slack, and Atom are all ready to go!\\nUse Spotlight search (Command + Spacebar) and type the app you want to open!" >> $NOTIFY_LOG
###
sleep 10
echo "Command: Image: /usr/local/images/ss.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Self Service makes the Mac life easier" >> $NOTIFY_LOG
echo "Command: MainText: Self Service includes helpful bookmarks and installers for other applications that may interest you." >> $NOTIFY_LOG
###
sleep 10
echo "Command: Image: /System/Library/PreferencePanes/SoftwareUpdate.prefPane/Contents/Resources/SoftwareUpdate.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Doing the hard work for you!" >> $NOTIFY_LOG
echo "Command: MainText: We're configuring network settings on your mac so you don't have to!" >> $NOTIFY_LOG
echo "Status: Setting DNS..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event setdns
sleep 2
###
sleep 10
echo "Command: Image: /usr/local/images/chrome.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing Google Chrome" >> $NOTIFY_LOG
echo "Command: MainText: Chrome is the worlds most powerful browser, but we'll install Firefox for you too!" >> $NOTIFY_LOG
echo "Status: Installing Chrome..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event chrome
###
echo "Command: Image: /usr/local/images/firefox.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: See! Told you!" >> $NOTIFY_LOG
echo "Command: MainText: We'd prefer if you use Chrome, but Firefox is here in case you need it." >> $NOTIFY_LOG
echo "Status: Installing Firefox..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event firefox
###
echo "Command: Image: /usr/local/images/iterm.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: iTerm 2" >> $NOTIFY_LOG
echo "Command: MainText: It's like Terminal, but for nerds." >> $NOTIFY_LOG
echo "Status: Installing iTerm..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event iterm
###
echo "Command: Image: /usr/local/images/atom.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Write your code with Atom" >> $NOTIFY_LOG
echo "Command: MainText: Atom is the best text editor....ever...." >> $NOTIFY_LOG
echo "Status: Installing Atom..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event atom
###
echo "Command: Image: /usr/local/images/jamf.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Keep all your passwords in sync!" >> $NOTIFY_LOG
echo "Command: MainText: Jamf Connect Sync is a menu bar item that is used to change your Mac AND Okta password. Neat!" >> $NOTIFY_LOG
echo "Status: Installing Jamf Connect Sync..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event jc-sync
###
echo "Command: Image: /usr/local/images/protect.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: The best protection" >> $NOTIFY_LOG
echo "Command: MainText: We're installing Jamf Protect which will help keep your Mac safe from threats!" >> $NOTIFY_LOG
echo "Status: Installing Jamf Protect..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event install-jp
###
echo "Command: Image: /usr/local/images/slack.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Message your co-workers!" >> $NOTIFY_LOG
echo "Command: MainText: It's 2020. No one sends emails. Please use Slack. For IT Help reach out to us in the #it-help Slack Room." >> $NOTIFY_LOG
echo "Status: Installing Slack..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event slack-2019
sleep 10
###
echo "Command: Image: /usr/local/images/jamf.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing our company icons." >> $NOTIFY_LOG
echo "Status: Installing Jamf Icon..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event jamf-icon
###
# echo "Command: Image: /usr/local/images/jamf.icns" >> $NOTIFY_LOG
# echo "Command: MainTitle: Installing a GIF!" >> $NOTIFY_LOG
# echo "Command: MainText: It's for the login window, you'll see later." >> $NOTIFY_LOG
# echo "Status: Installing Jamf GIF..." >> $NOTIFY_LOG
# /usr/local/bin/jamf policy -event jamf-GIF
sleep 5
###
echo "Command: Image: /System/Library/PreferencePanes/Accounts.prefPane/Contents/Resources/AccountsPref.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Making standard account." >> $NOTIFY_LOG
echo "Command: MainText: We're making a standard account for testing purposes." >> $NOTIFY_LOG
echo "Status: Creating Jamf Standard user..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event jamf-standard
sleep 10
###
echo "Command: Image: /usr/local/images/electron.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Setting Wallpaper." >> $NOTIFY_LOG
echo "Command: MainText: We're setting the wallpaper because why not." >> $NOTIFY_LOG
echo "Status: Wrapping Up!..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event set-wallpaper
sleep 10
###
echo "Command: Image: /System/Library/PreferencePanes/Accounts.prefPane/Contents/Resources/AccountsPref.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Making Hidden Admin" >> $NOTIFY_LOG
echo "Command: MainText: We're making a hidden admin account in case you get locked out." >> $NOTIFY_LOG
echo "Status:  Almost there!..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event sunnyvaleit-admin
sleep 5
###
echo "Command: Image: /usr/local/images/electron.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Resetting PAM" >> $NOTIFY_LOG
echo "Command: MainText: PAM PAM PAM!!!" >> $NOTIFY_LOG
echo "Status:  Done!..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event reset-pam
sleep 5

###
### Clean Up
###

sleep 3
echo "Command: Quit" >> $NOTIFY_LOG

sleep 1
echo "setup done" >> /var/tmp/notifydone
rm -rf $NOTIFY_LOG

/usr/local/bin/authchanger -reset -Okta
