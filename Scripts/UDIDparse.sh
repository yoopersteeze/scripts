#!/bin/bash

loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
echo ""
read -p "Please feed me the location of the logs: " logsLocation

until [ -f "$logsLocation" ]; do
    echo "File not found!"
    echo "Please try again."
    echo " "
    read -p "Please feed me the location of the logs: " logsLocation
done

echo ""
echo "Exporting List of UUIDs to ~/Desktop/UUIDs.txt"


file1="/Users/$loggedInUser/Desktop/Desktop/UUIDs.txt"
file2="/Users/$loggedInUser/Desktop/Desktop/UUID-1s.txt"

egrep "DeviceNotFoundException" "$logsLocation" | awk '{ print $10 }' | sort | uniq > $file1
if [[ -e "$file1" ]]; then
  mv "$file1" "$file2"
fi

echo ""
echo "Opening ~/Desktop/UUIDs.txt"
open $file1
echo ""
echo "Exiting Script"
