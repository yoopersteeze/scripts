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
# This script can be used to mark computers as unmanaged in Jamf Pro from a list of CSV
# seperated by comma.
# Example:
# 63,
# 64,
# 65,
# 66,
# 67
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
####################################################################################################

read -p "Jamf Pro URL: " server
read -p "Jamf Pro Username: " username
read -s -p "Jamf Pro Password: " password
echo ""
read -p "Please drag and drop the csv into this window and hit enter: " deviceList

####################################################################################################
#
# MAIN PROCESS
#
####################################################################################################

# Courtesy of github dot com slash iMatthewCM
#Read CSV into array
IFS=$'\n' read -d '' -r -a deviceIDs < $deviceList

length=${#deviceIDs[@]}

#Do all the things
for ((i=0; i<$length;i++));

do
  id=$(echo ${deviceIDs[i]} | sed 's/,//g' | sed 's/ //g'| tr -d '\r\n')
  curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/computers/id/$id -d "<computer><general><remote_management><managed>false</managed></remote_management></general></computer>" -X PUT
done
