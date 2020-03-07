#!/bin/bash

jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
icon=/Library/Application\ Support/JAMF/bin/acmesoft.png
windowType="hud"
description="An update to ACME Soft is available! Please click install now to open the AST Mac App Store and install the latest version in the Licensed Apps & Tools tab. If you no longer use AST, please delete it to avoid vulnerabilities. Thank you."
button1="Update Now"
button2="Later"
title="Update ACME Soft"
alignDescription="justified"
alignHeading="justified"
defaultButton="1"
cancelButton="1"


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# jamfHelper Window
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

userChoice=$("$jamfHelper" -windowType "$windowType" -lockHUD -title "$title" -defaultButton \
"$defaultButton" -cancelButton "$cancelButton" -icon "$icon" -description "$description" \
-alignDescription "$alignDescription" -alignHeading "$alignHeading" -button1 "$button1" -button2 "$button2")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Logging
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# If user selects "Update Now"
if [ "$userChoice" == "0" ]; then
   /usr/local/bin/jamf policy -event customTriggerNameHere
# If user selects "Later"
elif [ "$userChoice" == "2" ]; then
   echo "User clicked Later; now exiting."
   exit 0
fi
