Duct Tape workflow to mimic a login trigger without having to do login trigger.

LaunchAgent runs as the currently logged in user and will touch a file at /Users/Shared (somewhere that every user has access to)
LaunchDaemon contains the WatchPath key and any time the touch file is modified the action will be triggered. In this case a custom
Jamf policy that will run at "login".
