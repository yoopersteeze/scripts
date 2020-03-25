#!/bin/bash
# Variables
# Credits to github dot com slash zacharyfisher
getUser=$(ls  "/Users/" | grep -v '^[.*]' | grep -v '.admin' | grep -v 'Administrator' | grep -v 'swlmanage'| grep -v 'Guest' |  grep -v 'Shared')
model=$(system_profiler SPHardwareDataType  | awk '/Model Identifier/ { print $3 }' | tr -d '0123456789,')
# Json Parsing Function
function jsonValue() {
KEY=$1
num=$2
awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}
# Okta API Call
curl -v -X GET \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-H "Authorization: SSWS apikey" \
"https://org.okta.com/api/v1/users/$getUser" >> /tmp/userinformation.txt
firstName=$(cat /tmp/userinformation.txt | jsonValue firstName | head -c 1)
lastName=$(cat /tmp/userinformation.txt | jsonValue lastName)
if [ "${model}" == "iMac" ] || [ "${model}" == "MacPro" ] || [ "${model}" == "Macmini" ]; then
echo "Computer is not a Laptop, renaming to computer-$firstName$lastName-$model"
#sudo scutil --set ComputerName computer-$firstInitial$lastName-$model
#sudo scutil --set LocalHostName computer-$firstInitial$lastName-$model
#sudo scutil --set HostName computer-$firstInitial$lastName-$model
else
echo "user computer, renaming to computer-$firstName$lastName"
#sudo scutil --set ComputerName computer-$firstInitial$lastName
#sudo scutil --set LocalHostName computer-$firstInitial$lastName
#sudo scutil --set HostName computer-$firstInitial$lastName
fi
rm -rf /tmp/userinformation.txt
