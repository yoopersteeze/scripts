#!/bin/bash

output="/tmp/ports.txt"
if [[ ! -f $output ]]; then
   echo "File does not exist, creating now!"
   touch $output
else
   echo "File Exits, removing now!"
   rm $output
fi
echo "Starting!"
echo "--Running APNS Ports Tests--"
echo "--APNS Ports --" >> "$output"
nc -vz 5-courier.push.apple.com 443 >> "$output" 2>&1
nc -vz 5-courier.push.apple.com 5223 >> "$output" 2>&1
echo "--Running MacOS Only Tests--"
echo "--MacOS Only Below --" >> "$output" 2>&1
nc -vz lcdn-registration.apple.com 443 >> "$output" 2>&1
nc -vz oscdn.apple.apple.com 443 >> "$output" 2>&1
nc -vz oscdn.apple.apple.com 80 >> "$output" 2>&1
nc -vz osrecovery.apple.com 80 >> "$output" 2>&1
nc -vz osrecovery.apple.com 443 >> "$output" 2>&1
nc -vz swcdn.apple.com 80 >> "$output" 2>&1
nc -vz swdist.apple.com 443 >> "$output" 2>&1
nc -vz swdownload.apple.com 80 >> "$output" 2>&1
nc -vz swdownload.apple.com 443 >> "$output" 2>&1
nc -vz swpost.apple.com 80 >> "$output" 2>&1
nc -vz swscan.apple.com 443 >> "$output" 2>&1
nc -vz tbcs.apple.com 443 >> "$output" 2>&1
nc -vz gg.apple.com 80 >> "$output" 2>&1
nc -vz gg.apple.com 443 >> "$output" 2>&1
nc -vz gnf-mdn.apple.com 443 >> "$output" 2>&1
nc -vz gnf-mr.apple.com 443 >> "$output" 2>&1
nc -vz gs.apple.com 80 >> "$output" 2>&1
nc -vz gs.apple.com 443 >> "$output" 2>&1
nc -vz ig.apple.com 443 >> "$output" 2>&1
nc -vz skl.apple.com 443 >> "$output" 2>&1
echo "--Running iOS Only Tests --"
echo "--iOS Only Below --" >> "$output" 2>&1
nc -vz ns.itunes.apple.com 443 >> "$output" 2>&1
echo "--Running Various Ports Test--"
echo "--Various Ports--" >> "$output"
nc -vz gateway.push.apple.com 2195 >> "$output" 2>&1
nc -vz gateway.sandbox.push.apple.com 2195 >> "$output" 2>&1
nc -vz gateway.push.apple.com 2196 >> "$output" 2>&1
nc -vz gateway.sandbox.push.apple.com 2196 >> "$output" 2>&1
nc -vz deploy.apple.com 443 >> "$output" 2>&1
echo "--Running Port 80 Tests--"
echo "--Port 80 Below--" >> "$output" 2>&1
nc -vz hrweb.cdn-apple.com 80 >> "$output" 2>&1
nc -vz itunes.apple.com 80 >> "$output" 2>&1
nc -vz mzstatic.com 80 >> "$output" 2>&1
nc -vz appldnld.apple.com 80 >> "$output" 2>&1
nc -vz itunes.apple.com 80 >> "$output" 2>&1
nc -vz mesu.apple.com 80 >> "$output" 2>&1
nc -vz swscan.apple.com 80 >> "$output" 2>&1
nc -vz xp.apple.com 80 >> "$output" 2>&1
nc -vz configuration.apple.com 80 >> "$output" 2>&1
nc -vz captive.apple.com 80 >> "$output" 2>&1
nc -vz static.ips.apple.com 80 >> "$output" 2>&1
nc -vz crl3.digicert.com 80 >> "$output" 2>&1
nc -vz crl4.digicert.com 80 >> "$output" 2>&1
nc -vz captive.apple.com 80 >> "$output" 2>&1
nc -vz crl.apple.com 80 >> "$output" 2>&1
nc -vz crl.entrust.com 80 >> "$output" 2>&1
nc -vz ocsp.apple.com 80 >> "$output" 2>&1
nc -vz ocsp.entrust.com 80 >> "$output" 2>&1
nc -vz ocsp.digicert.com 80 >> "$output" 2>&1
nc -vz ocsp.verisign.com 80 >> "$output" 2>&1
nc -vz updates-http.cdn-apple.com 80 >> "$output" 2>&1
nc -vz updates-cdn-apple.com 443 >> "$output" 2>&1
echo "--Running Port 443 Tests --"
echo "--Port 443 Below --" >> "$output" 2>&1
nc -vz hrweb.cdn-apple.com 443 >> "$output" 2>&1
nc -vz itunes.apple.com 443 >> "$output" 2>&1
nc -vz mzstatic.com 443 >> "$output" 2>&1
nc -vz albert.apple.com 443 >> "$output" 2>&1
nc -vz appldnld.apple.com 443 >> "$output" 2>&1
nc -vz itunes.apple.com 443 >> "$output" 2>&1 2>&1
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
nc -vz a3.mzstatic.com 443 >> "$output" 2>&1
nc -vz apps.apple.com 443 >> "$output" 2>&1
nc -vz captive.apple.com 443 >> "$output" 2>&1
echo "Done! Outfile at /tmp/ports.txt"
