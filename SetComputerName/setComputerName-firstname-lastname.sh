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
#gets the logged in user
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
#gets named
firstName=$(finger -s "$loggedInUser" | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
echo "First initial is: $firstInitial"
lastName=$(finger -s "$loggedInUser" | head -2 | tail -n 1 | awk '{print tolower($4)}')
echo "Last name is: $lastName"
computerName="$firstName.$lastName"
echo "Setting computer name to: $computerName"

/usr/local/bin/jamf setComputerName -name "$computerName"
scutil --set ComputerName "$computerName"
scutil --set LocalHostName "$computerName"
scutil --set HostName "$computerName"
dscacheutil -flushcache
