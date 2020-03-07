#!/bin/bash
#variable for storing the current users name
loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )
#substituting as user stored in variable to modify plist
su "$loggedInUser" -c "<command to run>"
