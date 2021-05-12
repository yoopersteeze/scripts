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
#this will always download the latest version of the company portal application
#This script will also install the company portal application as well
out="/Users/Shared/intune.pkg"
/usr/bin/curl -k -L "https://go.microsoft.com/fwlink/?linkid=862280" --output "$out"
/usr/sbin/installer -pkg "$out" -target /
#clean up
rm -rf "$out"
exit 0
