#!/bin/sh
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -targetdisk / -activate -configure -clientopts -setmenuextra -menuextra yes
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -targetdisk / -configure -users 'Put,Your,Users,ShortName,Here' -access -on -privs -all
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -targetdisk / -configure -allowAccessFor -specifiedUsers -privs -all
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -targetdisk / -restart -agent -menu
/usr/sbin/systemsetup -setremotelogin on
exit 0
