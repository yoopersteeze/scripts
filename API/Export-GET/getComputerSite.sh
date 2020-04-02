#!/bin/bash
username="user"
password="user"
server="https://server.jamfcloud.com"
sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

site=$(curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/serialnumber/$sn | xmllint --xpath "computer/general/site/name/text()" -)
echo $site
