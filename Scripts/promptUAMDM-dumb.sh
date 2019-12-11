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

#Scope this to a SmartGroup of Non-User Approved Machines, Ongoing / Once Per Day
#Use Jamf Helper to display message to the end user to "Approve" their MDM Profile
/usr/local/bin/jamf displayMessage -message "Enter Custom Message Here to click Approve MDM Profile"
#Give the user 5 seconds to read the message before opening System Preferences > Profiles
sleep 5
#Open System Preferences > Profiles
#The user will have to click on MDM Profile > Approve
open /System/Library/PreferencePanes/Profiles.prefPane
