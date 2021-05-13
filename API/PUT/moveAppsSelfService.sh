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

server=""
username=""
password=""

####################################################################################################

appIDs=$(/usr/bin/curl -s -u "$username":"$password" -H "accept: application/xml" $server/JSSResource/mobiledeviceapplications | xmllint --format - | awk -F '[<>]' '/<id>/{print $3}')

for id in $appIDs;do
	/usr/bin/curl -s -u "$username":"$password" -H "accept: application/xml" $server/JSSResource/mobiledeviceapplications/id/$id/subset/General | xmllint --format - > /tmp/app-$id.xml
	appName=$(xmllint --xpath '/mobile_device_application/general/name/text()' /tmp/app-$id.xml)
	deployAutomatically=$(xmllint --xpath '/mobile_device_application/general/deploy_automatically/text()' /tmp/app-$id.xml)
	if [[ "$deployAutomatically" == "true" ]]; then
		echo "$appName is set to Install Automatically: $deployAutomatically"
#		echo "Moving Category for $appName to Applications"
#		/usr/bin/curl -s -u "$username":"$password" -H "content-type: text/xml" $server/JSSResource/mobiledeviceapplications/id/$id/subset/General -d "<mobile_device_application><general><category><name>Applications</name></category></general></mobile_device_application>" -X PUT > /dev/null
		/bin/rm /tmp/app-$id.xml
	else
		echo "Moving Category for $appName to Self Service"
		/usr/bin/curl -s -u "$username":"$password" -H "content-type: text/xml" $server/JSSResource/mobiledeviceapplications/id/$id/subset/General -d "<mobile_device_application><general><category><name>Self Service</name></category></general></mobile_device_application>" -X PUT > /dev/null
		/bin/rm /tmp/app-$id.xml
	fi
done
