#!bin/bash

loggedInUser=$( python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");' )

ss_user=`/bin/cat /Users/"$loggedInUser"/Library/Logs/JAMF/selfservice_debug.log | /usr/bin/grep "state: active, user:" | /usr/bin/tail -1 | /usr/bin/grep -o '".*"' | /usr/bin/sed 's/"//g'`

echo "<result>$ss_user</result>"
