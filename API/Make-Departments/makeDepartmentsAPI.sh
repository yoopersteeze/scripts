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
# ABOUT THIS PROGRAM
#
# NAME
#	makeDepartmentsAPI.sh - Add Departments to JSS via REST API
#
# DESCRIPTION
#
#	This script reads in a .csv file with Deparments then creates them via curl
#
# REQUIREMENTS
#
#   This script requires a .csv file with a list of departments. Each name must be on a
#   new line seperated by comma.
#
#	Example:
#
#		Support,
# 	Information Technology,
#	 	Accounting,
# 	Finance,
# 	Human Resources,
# 	Legal,
#		Ministry of Magic
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
read -p "Please drag and drop the CSV into this window and hit enter: " filePath

# Below courtesy of GitHub dot com slash iMatthewCM
#Department name we want to appear in the JSS. This variable will continually be rewritten once we get to the FOR loop
deptName=""

#Read in the file
IFS=$'\n' read -d '' -r -a lines < $filePath

#Get how many times we're looping based on length of array
length=${#lines[@]}
#Loop through lines
for ((i=0; i<$length;i++));
	do
		#Get the contents of the line and nuke the comma
		deptName=$(echo ${lines[i]} | sed 's/,//g' | tr -d '\r\n')
		#If the string isn't empty
		if [ -n "$deptName" ]; then
			# POST each department
			curl -ksu "$username":"$password" -H "content-type: application/xml" "$server"/JSSResource/departments/id/-1 -d "<department><name>$deptName</name></department>" -X POST
		fi
done
