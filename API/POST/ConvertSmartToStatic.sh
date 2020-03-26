#!/bin/sh
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
#
#	This script converts the membership of either computer, mobile device or user smart group
# into a new static group. The new static group name will automatically append - Static to the end.
# Example: If new name entered is "iOS 12", the static group would be named "iOS 12 - Static"
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
####################################################################################################
# Snippet below inspired by github dot com slash zdorow 
echo "Trying test call to Jamf Pro..."
test=$(curl --fail -ksu "$username":"$password" "$server"/JSSResource/users -X GET)
status=$?
if [ $status -eq 6 ]; then
	echo ""
	echo "The Jamf Pro URL is incorrect. Please edit the URL and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 22 ]; then
	echo ""
	echo "Username and/or password is incorrect. Please edit and try again."
	echo "If the error persists please check permissions and internet connection"
	echo ""
	exit 99
elif [ $status -eq 0 ]; then
    echo ""
    echo "Connection test successful! Starting API calls...."
    echo ""
else
    echo ""
    echo "Something went really wrong,"
    echo "Lets try this again."
    exit 99
fi
####################################################################################################
read -p "Enter 1 for Mobile Devices, 2 for Computers or 3 for Users: " deviceType
if [[ $deviceType -eq "1" ]];
then
  deviceType="Mobile Devices"
  group="mobile_device_group"
  devices="mobile_devices"
  apiURL="mobiledevicegroups"
elif [[ $deviceType -eq "2" ]];
then
  deviceType="Computers"
  group="computer_group"
  devices="computers"
  apiURL="computergroups"
else
  deviceType="Users"
  group="user_group"
  devices="users"
  apiURL="usergroups"
fi
read -p "Enter the ID of the ${deviceType} Smart Group: " ID
echo ""
echo "The new static group name entered will automatically append '- Static' to the end."
read -p "Enter a name for the new ${deviceType} Static Group (spaces are okay): " name
echo ""
read -p "Enter the Site ID (If none, enter 0): " siteID

if [[ $siteID -eq "0" ]]
then
  siteID="-1"
fi

#Get a list of computers or mobile devices currently in the smart group
var=`curl -ksu ${username}:${password} ${server}/JSSResource/${apiURL}/id/${ID} -X GET | awk -F $devices '{print $2}'`

#Reformatting to create the XML
a="<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
b="<${group}><name>${name} - Static</name>"
c="<is_smart>false</is_smart><site><id>$siteID</id></site><${devices}"
d="${devices}></${group}>"
var=${a}${b}${c}${var}${d}

#Output the data to an XML file
echo "${var}" > /tmp/newGroup.xml

#Submit the XML to the API
curl -ksu ${username}:${password} ${server}/JSSResource/${apiURL}/name/Name -T "/tmp/newGroup.xml" -X POST

#Cleanup the XML file
rm /tmp/newGroup.xml

exit 0
