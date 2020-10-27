#!/bin/bash

# credits to nick k
jamfproserver="https://jamf.disneystreaming.com:8443"
response="$(curl -s $jamfproserver/healthCheck.html)"
until [ "$response" = "[]" ]
do
	printf "\e[2m(%s) \e[0m%s status: \e[31mOffline\e[0m\n" "$(date)" "$jamfproserver"
	response="$(curl -s $jamfproserver/healthCheck.html)"
	sleep 5
done
printf "\e[2m(%s) \e[0m%s status: \e[32mOnline\e[0m\n" "$(date)" "$jamfproserver"
exit 0