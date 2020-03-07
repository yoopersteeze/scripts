#!/bin/bash

username=""
password=""
server=""
id=""

curl -ksu "$username":"$password" -H "content-type: text/xml" "$server"/JSSResource/policies/id/$id -d "<policy><self_service><use_for_self_service>true</use_for_self_service></self_service></policy>" -X PUT
