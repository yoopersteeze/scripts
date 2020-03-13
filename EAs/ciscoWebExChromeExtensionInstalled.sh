#!/bin/bash
# Detects if CiscoWebEx Chrome Extension is installed
# chrome://extensions/?id=jlhmfgmfgeifomenelglieieghnjghma
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )
ext="/Users/$loggedInUser/Library/Application Support/Google/Chrome/Default/Extensions/jlhmfgmfgeifomenelglieieghnjghma/"
if [[ ! -d "$ext" ]]; then
  echo "<result>Not Installed</result>"
else
  echo "<result>Installed</result>"
fi
