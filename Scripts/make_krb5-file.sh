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
# DESCRIPTION
#
# This script will make a krb5.conf file and set permissions
# Edit line 23 and set DOMAIN.NAME to the actual value it needs to be
####################################################################################################

file="/etc/krb5.conf"

cat << EOF > $file
[libdefaults]
default_realm = DOMAIN.NAME
EOF

/usr/sbin/chown root:wheel $file
/bin/chmod 644 $file

exit 0
