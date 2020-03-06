#!/bin/bash

output="/tmp/ports.txt"
if [[ ! -f $output ]]; then
   echo "File does not exist, creating now!"
   touch $output
else
   echo "File Exits, removing now!"
   rm $output
fi
echo "--Various Ports--" >> "$output"
nc -vz gateway.push.apple.com 2195 >> "$output" 2>&1
nc -vz gateway.sandbox.push.apple.com 2195 >> "$output" 2>&1
nc -vz gateway.push.apple.com 2196 >> "$output" 2>&1
nc -vz gateway.sandbox.push.apple.com 2196 >> "$output" 2>&1
nc -vz 35-courier.push.apple.com 5223 >> "$output" 2>&1
nc -vz deploy.apple.com 443 >> "$output" 2>&1
echo "--Port 80 Below--" >> "$output" 2>&1
nc -vz hrweb.cdn-apple.com 80 >> "$output" 2>&1
nc -vz itunes.apple.com 80 >> "$output" 2>&1
nc -vz mzstatic.com 80 >> "$output" 2>&1
nc -vz appldnld.apple.com 80 >> "$output" 2>&1
nc -vz gg.apple.com 80 >> "$output" 2>&1
nc -vz gs.apple.com 80 >> "$output" 2>&1
nc -vz itunes.apple.com 80 >> "$output" 2>&1
nc -vz mesu.apple.com 80 >> "$output" 2>&1
nc -vz swscan.apple.com 80 >> "$output" 2>&1
nc -vz xp.apple.com 80 >> "$output" 2>&1
nc -vz configuration.apple.com 80 >> "$output" 2>&1
nc -vz captive.apple.com 80 >> "$output" 2>&1
nc -vz static.ips.apple.com 80 >> "$output" 2>&1
nc -vz crl3.digicert.com 80 >> "$output" 2>&1
nc -vz crl4.digicert.com 80 >> "$output" 2>&1
nc -vz ocsp.digicert.com 80 >> "$output" 2>&1
echo "--Port 443 Below --" >> "$output" 2>&1
nc -vz hrweb.cdn-apple.com 443 >> "$output" 2>&1
nc -vz itunes.apple.com 443 >> "$output" 2>&1
nc -vz mzstatic.com 443 >> "$output" 2>&1
nc -vz albert.apple.com 443 >> "$output" 2>&1
nc -vz appldnld.apple.com 443 >> "$output" 2>&1
nc -vz gg.apple.com 443 >> "$output" 2>&1
nc -vz gs.apple.com 443 >> "$output" 2>&1
nc -vz itunes.apple.com 443 >> "$output" 2>&1 2>&1
nc -vz skl.apple.com 443 >> "$output" 2>&1
nc -vz mesu.apple.com 443 >> "$output" 2>&1
nc -vz swscan.apple.com 443 >> "$output" 2>&1
nc -vz xp.apple.com 443 >> "$output" 2>&1
nc -vz configuration.apple.com 443 >> "$output" 2>&1
nc -vz captive.apple.com 443 >> "$output" 2>&1
nc -vz humb.apple.com 443 >> "$output" 2>&1
nc -vz static.ips.apple.com 443 >> "$output" 2>&1
nc -vz tbsc.apple.com 443 >> "$output" 2>&1
nc -vz gdmf.apple.com 443 >> "$output" 2>&1
nc -vz deviceenrollment.apple.com 443 >> "$output" 2>&1
nc -vz deviceservices-external.apple.com 443 >> "$output" 2>&1
nc -vz identity.apple.com 443 >> "$output" 2>&1
nc -vz iprofiles.apple.com 443 >> "$output" 2>&1
nc -vz mdmenrollment.apple.com 443 >> "$output" 2>&1
nc -vz vpp.itunes.apple.com 443 >> "$output" 2>&1
nc -vz ppq.apple.com 443 >> "$output" 2>&1
nc -vz crl3.digicert.com 443 >> "$output" 2>&1
nc -vz crl4.digicert.com 443 >> "$output" 2>&1
nc -vz ocsp.digicert.com 443 >> "$output" 2>&1
echo "Done"
