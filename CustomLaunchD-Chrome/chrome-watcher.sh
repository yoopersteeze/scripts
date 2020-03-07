#!/bin/bash

chromeVersion="defaults read /Applications/Google\ Chrome.app/Contents/Info.plist CFBundleShortVersionString"
theDate=$(date '+%m/%d/%Y %H:%M:%S')
log="/var/tmp/chromey.log"
if [[ ! -f $log ]]; then
	touch $log
	echo "$theDate - Log File Created" >> "$log"
fi
if [[ -z "$chromeVersion" ]];then
	echo "$theDate - Not Found" >> $log
	echo "$theDate Calling Chrome Policy" >> $log
	/usr/local/bin/jamf policy -event chrome
else
	echo "$theDate - Chrome Version $chromeVersion installed" >> $log
fi
