#!/bin/sh
# Sites are not meant for scoping so don't do this
username="user"
password="user"
server="https://server.jamfcloud.com"
sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

siteName=$(curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/serialnumber/$sn | xmllint --xpath "computer/general/site/name/text()" -)

if [[ "$siteName" != "" ]]; then
  echo "<result>$siteName</result>"
else
  echo "<result>None</result>"
fi
