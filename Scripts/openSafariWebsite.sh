#!/bin/bash
# This script is used to open a number of useful links while employees are proceeding through their Onboarding

open -a "Safari" 'https://jamf.com/jamf-nation'

osascript -e 'tell application "System Events" to keystroke "1" using {command down}'

exit 0
