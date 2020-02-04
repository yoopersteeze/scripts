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
# This can upload a file to the JCDS thru the API
# Credit go to Jamf Nation User: Yamashiro for inspiration
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "File Name (including file type): " filename
read -p "Full path to file (/tmp/mypackage.pkg): " path
####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################

curl -u "$username":"$password" -X POST "$server"/dbfileupload -H 'DESTINATION: 0' -H 'OBJECT_ID: -1' -H 'FILE_TYPE: 0' -H 'FILE_NAME: '$filename'' -T "$path"
