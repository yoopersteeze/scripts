#!/bin/bash
# This will upload jamf.log, system.log and install.log for machines that are in scope of a policy that runs this script
# You can also specify a different file by uncommenting line 11 and entering the full file path
################################
username="$4" # jamf pro username
password="$5" #jamf pro password
server="$6" # jamf pro url Example: https://mycompany.jamfcloud.com (jamfcloud) || https://mycompany.com:8443 (on-prem)
################################
# SPECIFY DIFFERENT FILE BELOW
################################
# file="$7"
################################
sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
id=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/computers/serialnumber/"$sn" | xmllint --xpath "computer/general/id/text()" -)
################################
# uncomment below if "$file" was specified in line 11. If you do not want the jamf.log, install.log or system.log, then comment out lines 19, 20 and 21
# curl -sku "$username":"$password" "$server"/JSSResource/fileuploads/computers/id/$id -X POST -F "name=@$file"
################################
curl -sku "$username":"$password" "$server"/JSSResource/fileuploads/computers/id/"$id" -X POST -F "name=@/private/var/log/jamf.log"
curl -sku "$username":"$password" "$server"/JSSResource/fileuploads/computers/id/"$id" -X POST -F "name=@/private/var/log/install.log"
curl -sku "$username":"$password" "$server"/JSSResource/fileuploads/computers/id/"$id" -X POST -F "name=@/private/var/log/system.log"
