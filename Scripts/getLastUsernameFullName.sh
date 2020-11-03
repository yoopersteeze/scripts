#!/bin/bash
# credits to Jordane Cau
#Get logged in user
lastUser=$(defaults read /Library/Preferences/com.apple.loginwindow lastUserName)
# Get the Full Name of the user
fullName=$(dscl . read /Users/$lastUser RealName | grep -v RealName | cut -c 2-)
#Invert Name Surname to be Surname name
fullNameJamf=$(echo "$fullName" | awk '{ for (i=NF; i>1; i--) printf("%s ",$i); print $1; }')
# Add the users full name to the computer record in the JSS
echo "$fullNameJamf"
