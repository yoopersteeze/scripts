#!/bin/bash

healthStatus=$(curl -m 10 -sk https://sunnyvale.support.jamf.net:8443/healthCheck.html)
theDate=$(date '+%m/%d/%Y %H:%M:%S')
log="/var/tmp/jamfProError.log"
if [[ ! -f $log ]]; then
	touch $log
	echo "Log file did not exist, creating it now"
	echo "$theDate - Log File Created" >> "$log"
fi
if [[ "$healthStatus" != "[]" ]];then
	echo "$theDate - Not Responding" >> $log
else 
	echo "$theDate - OK!" >> $log  
fi