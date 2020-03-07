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
#
# DESCRIPTION
# Prompt the end user of a machine to select their graduation year from a list, then update an
# Extension attribute for their graduation year.
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

username="$4"
password="$5"
server="$6"
eaName="$7"

sn=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
id=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/computers/serialnumber/"$sn" | xmllint --xpath "computer/general/id/text()" -)

gradChoices={"2019","2020","2021","2022"}

theCommand="choose from list $gradChoices with prompt \"Please select your graduation year:\" default items {"2019"}"

result=$( /usr/bin/osascript -e "$theCommand" )

echo "$result"

# Create xml
/bin/cat << EOF > /private/tmp/ea.xml
<computer>
	<extension_attributes>
		<extension_attribute>
			<name>$eaName</name>
			<value>$result</value>
		</extension_attribute>
	</extension_attributes>
</computer>
EOF

## Upload the xml file
curl -sfku "${username}":"${password}" "${server}/JSSResource/computers/id/$id" -T /private/tmp/ea.xml -X PUT
# Uncomment below to remove xml file
rm /private/tmp/ea.xml
exit 0
