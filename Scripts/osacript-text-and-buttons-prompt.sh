#!/bin/bash

results=$( osascript -e "display dialog \"Text and Buttons!\" default answer \"Some text...\" buttons {\"Cancel\",\"OK\"} default button {\"OK\"}" )

theButton=$( echo "$results" | awk -F "button returned:|," '{print $2}' )
theText=$( echo "$results" | awk -F "text returned:" '{print $2}' )

exit 0