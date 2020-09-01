#!/bin/bash
# credits to zacharyfisher
### Print Certificates to file
#security find-certificate -a -Z '/Library/Keychains/System.keychain' > certificates.txt
#
### Parse Specific Certificates to new TXT File
#cat certificates.txt| grep -i -B 9 'ACME Soft Intermediate CA' > newCertificates.txt
#rm -rf certificates.txt
#
#
## Put SHA-1 Values into Array
#my_array=( $(cat newCertificates.txt | grep 'SHA-1 hash' | awk '{ print $3 }') )
#rm -rf newCertificates.txt
#
#for sha1 in "${my_array[@]}"
# do
# echo "${sha1}"
# echo "Deleting Certificates"
# security delete-certificate -Z "${sha1}"
# done

# Get Current User
currentUser=`stat -f "%Su" /dev/console`
# Grabs the expired certificate hashes
expired=$(security find-identity | grep EXPIRED | awk '{print $2}')

# Puts Expired Certs into Array
my_array=( $(security find-identity | grep EXPIRED | awk '{print $2}') )

# Check for certs

if [ -z "$expired" ]
then
echo "No expired certificates, we're all good"
else
# Deletes the expired certs via their hash
for expired in "${my_array[@]}"
do
echo "${expired}"
echo "Deleting Certificates"
su $currentUser -c "security delete-certificate -Z "${expired}""
done
fi

exit 0 #success
