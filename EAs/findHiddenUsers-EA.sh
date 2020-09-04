#!/bin/bash

for user in $(dscl . list /Users IsHidden | grep -v '_' | awk '{print $1}');do
  echo "<result>$user</result>"
done
