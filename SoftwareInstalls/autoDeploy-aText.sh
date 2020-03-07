#!/bin/bash

#Download aText installer and put it in /tmp/
curl 'http://www.trankynam.com/atext/downloads/aText.dmg' -o /tmp/aText.dmg

#Mount the aText disk image
hdiutil attach /tmp/aText.dmg

#Copy aText to the applications folder -r for recursive
cp -r /Volumes/aText/aText.app /Applications/

#Unmount and delete the disk image
hdiutil detach /Volumes/aText/
rm /tmp/aText.dmg