#!/bin/bash
#this will always download the latest version of the company portal application
#This script will also install the company portal application as well
curl -k -L "https://go.microsoft.com/fwlink/?linkid=862280" --output /Users/Shared/intune.pkg
cd /Users/Shared
installer -pkg /Users/Shared/intune.pkg -target /
#clean up
rm -rf /Users/Shared/intune.pkg
exit 0
