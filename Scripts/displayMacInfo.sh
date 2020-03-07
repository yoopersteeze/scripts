#!/bin/bash
# Not sure who wrote this, but it was not me.
#en0Address=`ifconfig en0 | grep "inet" | cut -d " " -f2`
en1Status=`ifconfig en1 | tr ' ' '\n' | grep "active"`
en0Status=`ifconfig en0 | tr ' ' '\n' | grep "active"`
CurrentUser=`who | grep "console" | awk '{print $1}'`
hostnamename=`hostname | cut -d "." -f 1`
computername=`jamf getComputerName | cut -d ">" -f2 | cut -d "<" -f1`
OSVersion=`sw_vers | grep "ProductVersion" | awk '{print $2}'`
en1MACAddress=`ifconfig en1 | grep "ether" | cut -d" " -f2`
en0MACAddress=`ifconfig en0 | grep "ether" | cut -d" " -f2`
TotalRam=`system_profiler SPHardwareDataType | grep "Memory:" | cut -d":" -f2`
BootVolume=`system_profiler SPSoftwareDataType | grep "Boot Volume:" | cut -d":" -f2`

TotalBootDriveSize=`system_profiler SPSerialATADataType | grep "$BootVolume" -A2 | grep "Capacity:" | cut -d ":" -f2 | cut -d "(" -f1`
AvailBootDriveSize=`system_profiler SPSerialATADataType | grep "$BootVolume" -A2 | grep "Available:" | cut -d ":" -f2 | cut -d "(" -f1`

if [ "$en1Status" == "active" ];
	then en1Address=`ifconfig en1 | grep "inet " | cut -d " " -f2`
	else en1Address="not active"
fi

if [ "$en0Status" == "active" ];
	then en0Address=`ifconfig en0 | grep "inet" | cut -d " " -f2`
	else en0Address="not active"
fi



jamf displayMessage -message "Wired address is $en0Address
Wireless address is $en1Address
Current Logged on user is $CurrentUser
Computer name is $computername
Hostname is $hostnamename
OS version is $OSVersion
Wired MAC Address is $en0MACAddress
Wireless MAC Address is $en1MACAddress
Total RAM (Memory):$TotalRam
Boot Volume:$BootVolume
	Total size:$TotalBootDriveSize
	Free space:$AvailBootDriveSize"
