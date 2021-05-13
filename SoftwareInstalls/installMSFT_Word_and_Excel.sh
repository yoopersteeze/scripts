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
# Install both MSFT Word and Excel via script with curl and installer binary
# This script can take a long time to complete depending on network speed
# It took 04:16 on a 38.1 Mbps download speed on my home network
# It's not the most elegant, but it worked for me
# Use as your own risk
####################################################################################################

# links to files that should always be most recent version
msft_word="https://go.microsoft.com/fwlink/?linkid=525134"
msft_excel="https://go.microsoft.com/fwlink/?linkid=525135"

# variable of outfile location
out_word="/Users/Shared/msft_word.pkg"
out_excel="/Users/Shared/msft_excel.pkg"

# curl the pkgs
curl -k -L "$msft_word" --output "$out_word"
curl -k -L "$msft_excel" --output "$out_excel"

# install the pkgs
installer -pkg "$out_word" -target /
installer -pkg "$out_excel" -target /

# cleanup
rm "$out_word" "$out_excel"
exit 0
