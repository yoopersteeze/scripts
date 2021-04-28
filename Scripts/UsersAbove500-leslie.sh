#!/bin/bash

oIFS=$IFS
IFS=" "
while read user;do
	echo "user: $user"
done <<< $( dscl . list /Users UniqueID | awk '$2 > 500 {print $1}')
IFS=$oIFS