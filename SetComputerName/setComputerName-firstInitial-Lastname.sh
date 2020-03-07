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

# Source: https://www.jamf.com/jamf-nation/discussions/26912/script-to-rename-computer-name-letter-of-first-name-and-last-name#responseChild159772

#gets current logged in user
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )

#gets named
# firstInitial=$(finger -s $loggedInUser | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
firstInitial=$(finger -s $loggedInUser | head -2 | tail -n 1 | awk '{print tolower($2)}' | cut -c 1)
lastName=$(finger -s $getUser | head -2 | tail -n 1 | awk '{print tolower($3)}')
computerName=$firstInitial$lastName"-mac"

#set all the name in all the places
/usr/sbin/scutil --set ComputerName "$computerName"
/usr/sbin/scutil --set LocalHostName "$computerName"
/usr/sbin/scutil --set HostName "$computerName"

# Uncomment below if wanting to use the jamf binary to set all the names
# /usr/local/bin/jamf setComputerName -name "$computerName"

# Uncomment below if you want to update inventory
#/usr/local/bin/jamf recon
