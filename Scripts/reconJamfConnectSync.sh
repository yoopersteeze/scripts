#!/bin/bash
#
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
#echo $loggedInUser
if [[ "$loggedInUser" == "_mbesetupuser" ]] || [[ "$loggedInUser" == "root" ]] ; then
	echo "No real user actually logged in."
	echo "Exiting as error."
	exit 1
else
	echo "Logged In User is: "$loggedInUser" proceeding..."
fi

file="/var/tmp/jcvalues.txt"

model=$(system_profiler SPHardwareDataType  | awk '/Model Identifier/ { print $3 }' | tr -d '0123456789,')
UserDisplayName=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync DisplayName)
UserFirstName=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync UserFirstName)
UserLastName=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync UserLastName)
#UserLoginName=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync.plist UserLoginName | sed 's/\@.*/@/' | sed 's/.$//')
UserShortName=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync.plist UserShortName)
UserEmail=$(/usr/bin/defaults read /Users/$loggedInUser/Library/Preferences/com.jamf.connect.sync.plist UserEmail)

echo "DisplayName: $UserDisplayName" >> $file
echo "UserFirstName: $UserFirstName" >> $file
echo "UserLastName: $UserLastName" >> $file
echo "UserShortName: $UserShortName">> $file
echo "UserEmail: $UserEmail" >> $file

/usr/local/bin/jamf recon -endUsername "$UserShortName"
/usr/local/bin/jamf recon -realname "$UserDisplayName"
/usr/local/bin/jamf recon -email "$UserEmail"
/usr/local/bin/jamf setComputerName -name "$UserDisplayName"-$model
