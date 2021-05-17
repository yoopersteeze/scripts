#!/bin/bash
# This will upload jamf.log, system.log and install.log for machines that are in scope of a policy that runs this script.
# You can change whatever files you want to zip by editing line 22 files
# Credit to kc9wwh on github for zipping the files before upload and some other variables.
################################
username="$4" # jamf pro username
password="$5" #jamf pro password
server="$6" # jamf pro url Example: https://mycompany.jamfcloud.com (jamfcloud) || https://mycompany.com:8443 (on-prem)
logsToUpload="$7" # insert array of full log / file paths here seperated by space

## System Variables
currentUser=$( stat -f%Su /dev/console )
compHostName=$( scutil --get LocalHostName )
timeStamp=$( date '+%Y-%m-%d-%H-%M-%S' )
sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
id=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/computers/serialnumber/"$sn" | xmllint --xpath "computer/general/id/text()" -)

## Log Collection
fileName="$currentUser"-"$compHostName"-"$timeStamp".zip
################################
# SPECIFY DIFFERENT FILES BELOW
################################
zip /private/tmp/$fileName "$logsToUpload"

# POST zip file to Jamf Pro
curl -sku "$username":"$password" "$server"/JSSResource/fileuploads/computers/id/"$id" -X POST -F "name=@/private/tmp/$fileName"

# Cleanup
rm /private/tmp/$fileName
