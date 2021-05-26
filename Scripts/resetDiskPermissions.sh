#!/bin/bash

# get logged in user
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# bail out if user is null, root or _mbsetupser
if [[ -z "$loggedInUser" || "$loggedInUser" == "root" || "$loggedInUser" == "_mbsetupser" ]]; then
    echo "No real user logged in"
    echo "Logged in user is: $loggedInUser"
    exit 1
else
  # run the command we need
/usr/sbin/diskutil resetUserPermissions / $(id -u "$loggedInUser")
fi
