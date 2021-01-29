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
# This is a self destruct script that will delete all classes in Jamf Pro.
# Requires a user that has READ and DELETE privys for Classes. It will read in
# parameters, so no need to change anything in the script.
####################################################################################################
#
# READ IN PARAMETERS (NO NEED TO CHANGE ANYTHING HERE)
#
####################################################################################################
echo "#####################"
echo "###!!! WARNING !!!###"
echo "#####################"
echo "This is a self destruct stript that will delete all classes."
echo "Please ensure you have a database backup."
echo "There is no magic undo button other than restoring to a backup when the classes were in existance."
read -p "Are you sure you want to continue? [ y | n ]  " answer
if [[ $answer != 'y' ]]; then
	echo "Exiting script!"
	exit 1
fi
read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

#Trim the trailing slash off if necessary courtesy of github dot com slash iMatthewCM
if [ $(echo "${server: -1}") == "/" ]; then
	server=$(echo $server | sed 's/.$//')
fi

echo "Deleting all classes now!"
classID=$(curl -ksu "$username":"$password" -H "accept: text/xml" "$server"/JSSResource/classes | xmllint --format - | awk -F '[<>]' '/id/{print $3}')
for class in $classID;do
	curl -ksu "$username":"$password" -H "Content-type: text/xml" "$server"/JSSResource/classes/id/"$class" -X DELETE
done
