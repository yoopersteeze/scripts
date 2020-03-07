#!/bin/bash

jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
icon="/Library/Application Support/JamfProtect/JamfProtect.app/Contents/Resources/AppIcon.icns"
windowType="hud"
description="Your machine has possibly been compromised. Please report to IT Immediately!"
button1="Ok"
heading="Oh No!"
title="Possible Malicious Application"
alignDescription="justified"
alignHeading="justified"
defaultButton="1"

userChoice=$("$jamfHelper" -windowType "$windowType" -lockHUD -title "$title" -defaultButton \
"$defaultButton" -cancelButton "$cancelButton" -icon "$icon" -description "$description" -heading "$heading" \
-alignDescription "$alignDescription" -alignHeading "$alignHeading" -button1 "$button1")

if [[ $userChoice == 0 ]]; then
	echo "user clicked $button1"
	jamfselfservice://content?entity=policy&id=1&action=view
fi