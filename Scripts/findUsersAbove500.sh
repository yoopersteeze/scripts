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

foo=()
array=$(dscl . list /Users UniqueID | awk '$2 > 500 {print $1}' )
for i in "$array";do
	foo="$i"
done
for i in ${foo[@]};do
	echo "<result>"$i"</result>"
done
