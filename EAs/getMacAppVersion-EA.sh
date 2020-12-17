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

app="Google Chrome.app"
version=$(defaults read /Applications/"$app"/Contents/Info.plist CFBundleShortVersionString)
file=/Applications/"$app"/Contents/Info.plist
if [[ ! -e $file ]]; then
	echo "<result>Not Installed</result>"
else
	echo "<result>$version</result>"
fi
