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
#
# DESCRIPTION
# This script can make a plist in the currently logged in users's library.
# This script ran as is will make a plist called com.companyname.descriptor.plist in the users
# library, setting the key loggedInUser to the currently logged in user.
#
####################################################################################################

# Get the logged in user
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
# Set the Path to the plist in the user library
plistPath=(/Users/$loggedInUser/Library/Preferences)
# Set the plistName to something that makes sense.
plistName="$plistPath/com.companyname.descriptor"

# Customize the different keys here.
/usr/bin/defaults write $plistName loggedInUser -string $loggedInUser

# Combine the full list
fullList=$plistName.plist

# Set permissions
/bin/chmod 644 $fullList
/usr/sbin/chown $loggedInUser:staff $fullList
