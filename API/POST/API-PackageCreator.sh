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
# This script will create a package record inside of Jamf Pro. Can be used when a large package
# such as a 20GB+ Adobe file cannot be uploaded to JCDS. Manually upload the file to a local SMB / HTTPS
# share, then use this script to create it's record inside of Jamf Pro.
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Package Name (including file extension)": packageName				#Name of the package (including file extension)
####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

curl -kvu ${username}:${password} -H "Content-Type: text/xml" ${server}/JSSResource/packages/id/-1 -d "<package><name>${packageName}</name><filename>${packageName}</filename></package>" -X POST

exit 0
