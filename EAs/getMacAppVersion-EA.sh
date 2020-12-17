#!/bin/bash

app="Google Chrome.app"
version=$(defaults read /Applications/"$app"/Contents/Info.plist CFBundleShortVersionString)
file=/Applications/"$app"/Contents/Info.plist
if [[ ! -e $file ]]; then
	echo "<result>Not Installed</result>"
else
	echo "<result>$version</result>"
fi