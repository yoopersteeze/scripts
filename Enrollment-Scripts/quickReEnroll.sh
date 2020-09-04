#!/bin/bash

read -p "Drag QuickAdd here: " QUICKPATH
pkgutil --expand "$QUICKPATH" /tmp/QuickAdd
enrollmentInvitation=$(cat /tmp/QuickAdd/Scripts/postinstall | grep "invitation" | awk '{ print $4 }')
echo $enrollmentInvitation
/usr/local/bin/jamf enroll -invitation $enrollmentInvitation
rm -r /tmp/QuickAdd
