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
# ABOUT THIS PROGRAM
#
# NAME
#	makeBuildingsAPI.sh - Adds Buildings to JSS via REST API
#
# DESCRIPTION
#
#	This script reads in a .csv file with Buildings then creates buildings via curl
#
# REQUIREMENTS
#
#   This script requires a .csv file with a list of Building names. Each name must be on a
#   new line seperated by comma.
#
#	Example:
#
#		Eau Claire,
#		Minneapolis,
# 	Sydney,
# 	Tokyo,
# 	Katowice,
#		Amersterdam
#
#
####################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
####################################################################################################
read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Please drag and drop the CSV file into this window and hit enter: " filePath

# Below courtesy of GitHub dot com slash iMatthewCM
#Building name we want to appear in the JSS. This variable will continually be rewritten once we get to the FOR loop
buildName=""

#Read in the file
IFS=$'\n' read -d '' -r -a lines < $filePath

#Get how many times we're looping based on length of array
length=${#lines[@]}
#Loop through lines
for ((i=0; i<$length;i++));
	do
		#Get the contents of the line and nuke the comma
		buildName=$(echo ${lines[i]} | sed 's/,//g' | tr -d '\r\n')
		#If the string isn't empty
		if [ -n "$buildName" ]; then
			# POST each building
			curl -ksu "$username":"$password" -H "content-type: application/xml" "$server"/JSSResource/buildings/id/-1 -d "<building><name>$buildName</name></building>" -X POST
		fi
done
