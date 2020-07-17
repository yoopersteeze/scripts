#!/bin/bash

loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
isCurrent=$(defaults read /Users/"$loggedInUser"/Library/Preferences/com.jamf.connect.sync PasswordCurrent)
echo "<result>$isCurrent</result>"
