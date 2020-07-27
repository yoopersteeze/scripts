#!/bin/bash

username="$4"
password="$5"
server="https://servername.jamfcloud.com"
eaName="$6"
eaValue="$7"

#######################################
##### DO NOT EDIT BELOW THIS LINE #####
#######################################

# GET THE SERIAL NUMBER OF THE MAC
sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

# GET THE COMPUTERID BASED OFF SERIAL NUMBER
id=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/computers/serialnumber/$sn | xmllint --xpath "computer/general/id/text()" -)

# CREATE XML FILE AT /TMP
/bin/cat << EOF > /private/tmp/ea.xml
<computer>
	<extension_attributes>
		<extension_attribute>
			<name>$eaName</name>
			<value>$eaValue</value>
		</extension_attribute>
	</extension_attributes>
</computer>
EOF

## PUT XML FILE TO COMPUTER RECORD
curl -sfku "${username}":"${password}" "${server}/JSSResource/computers/id/$id" -T /private/tmp/ea.xml -X PUT

# REMOVE THE XML FILE
rm /private/tmp/ea.xml
exit 0
