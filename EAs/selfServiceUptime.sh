#!/bin/bash

SelfServiceUpTime=$(ps -ax -o etime,command -c | grep "Self Service" | awk '{print $1}')

echo "<result>$SelfServiceUpTime</result>"