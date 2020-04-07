#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Copyright (c) 2017 Jamf.  All rights reserved.
#
#       Redistribution and use in source and binary forms, with or without
#       modification, are permitted provided that the following conditions are met:
#               * Redistributions of source code must retain the above copyright
#                 notice, this list of conditions and the following disclaimer.
#               * Redistributions in binary form must reproduce the above copyright
#                 notice, this list of conditions and the following disclaimer in the
#                 documentation and/or other materials provided with the distribution.
#               * Neither the name of the Jamf nor the names of its contributors may be
#                 used to endorse or promote products derived from this software without
#                 specific prior written permission.
#
#       THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
#       EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#       WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#       DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#       (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#       LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#       ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#       (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#       SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# This script was designed to be used when migration Jamf Pro instances where an MDM profile
# is installed on the systems and needs to be removed prior to the migration.
#
# To accomplish this the following will be performed:
#			- Attempt removal via Jamf binary
#			- Attempt removal via Jamf API sending an MDM UnmanageDevice command
#			- Lastly, if failed to remove MDM Profile the /var/db/ConfigurationProfiles
#             folder will be renamed.
#
# REQUIREMENTS:
#			- Jamf Pro
#			- Jamf Pro API User with permission to read computer objects
#			- Jamf Pro API User with permission to send management commands
#           		- Script must be executed as root (due to profiles command)
#
# EXIT CODES:
#			0 - Everything is Successful
#			1 - Unable to remove MDM Profile
#
# For more information, visit https://github.com/kc9wwh/removeJamfProMDM
#
#
# Written by: Joshua Roskos | Professional Services Engineer | Jamf
#
# Created On: December 7th, 2017
# Updated On: December 7th, 2017
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# USER VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

jamfProURL="$4"                       # URL of the Jamf Pro server (ie. https://jamf.acme.com:8443)
apiUser="$5"                          # API user account in Jamf Pro w/ Update permission
apiPass="$6"                          # Password for above API user account

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# SYSTEM VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

osMinorVersion=$( /usr/bin/sw_vers -productVersion | /usr/bin/cut -d. -f2 )
timestamp=$( /bin/date '+%Y-%m-%d-%H-%M-%S' )
mySerial=$( system_profiler SPHardwareDataType | grep Serial |  awk '{print $NF}' )
jamfProCompID=$( /usr/bin/curl -s -u ${apiUser}:${apiPass} ${jamfProURL}/JSSResource/computers/serialnumber/${mySerial}/subset/general | /usr/bin/xpath "//computer/general/id/text()" )

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

checkMDMProfileInstalled() {
    enrolled=`/usr/bin/profiles -C | /usr/bin/grep "00000000-0000-0000-A000-4A414D460003"`
    if [ "$enrolled" != "" ]; then
    	echo "MDM Profile Present..."
        mdmPresent=1
    else
    	echo "MDM Profile Successfully Removed..."
        mdmPresent=0
    fi
}

jamfUnmanageDeviceAPI() {
    /usr/bin/curl -s -X POST -H "Content-Type: text/xml" -u ${apiUser}:${apiPass} ${jamfProURL}/JSSResource/computercommands/command/UnmanageDevice/id/${jamfProCompID}
    sleep 10
    checkMDMProfileInstalled
    counter=0
    until [ "$mdmPresent" -eq "0" ] || [ "$counter" -gt "9" ]; do
        ((counter++))
        echo "Check ${counter}/10; MDM Profile Present; waiting 30 seconds to re-check..."
        sleep 30
        checkMDMProfileInstalled
    done
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APPLICATION
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Remove Configuration Profiles
echo "Removing MDM Profiles ..."
if [ "${osMinorVersion}" -ge 13 ]; then
	echo "macOS `/usr/bin/sw_vers -productVersion`; attempting removal via jamf binary..."
	/usr/local/bin/jamf removeMdmProfile -verbose
    sleep 3
    checkMDMProfileInstalled
    if [ "$mdmPresent" == "0" ]; then
        echo "Successfully Removed MDM Profile..."
    else
        echo "MDM Profile Present; attempting removal via API..."
        jamfUnmanageDeviceAPI
        if [ "$mdmPresent" != "0" ]; then
            echo "Unable to remove MDM Profile; exiting..."
            exit 1
        fi
    fi
else
	echo "macOS `/usr/bin/sw_vers -productVersion`; attempting removal via jamf binary..."
	/usr/local/bin/jamf removeMdmProfile -verbose
    sleep 3
    checkMDMProfileInstalled
    if [ "$mdmPresent" == "0" ]; then
        echo "Successfully Removed MDM Profile..."
    else
        echo "MDM Profile Present; attempting removal via API..."
        jamfUnmanageDeviceAPI
        if [ "$mdmPresent" == "0" ]; then
            echo "Successfully Removed MDM Profile..."
        else
            echo "macOS `/usr/bin/sw_vers -productVersion`; attempting force removal..."
        	/bin/mv -v /var/db/ConfigurationProfiles/ /var/db/ConfigurationProfiles-$timestamp
            checkMDMProfileInstalled
            if [ "$mdmPresent" != "0" ]; then
                echo "Unable to remove MDM Profile; exiting..."
                exit 1
            fi
        fi
    fi
fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# CLEANUP & EXIT
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

exit 0
