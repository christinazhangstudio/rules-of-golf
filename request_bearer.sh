#!/bin/bash

url='XXX.com'

CLIENT_SECRET=XXX
CLIENT_ID=XXX
GRANT_TYPE='client_credentials'
RESOURCE='XXX.com'

resp=$(curl -s -X POST -d "client_secret=$CLIENT_SECRET&client_id=$CLIENT_ID&grant_type=$GRANT_TYPE&resource=$RESOURCE" -H "Content-Type: application/x-www-form-urlencoded" "$url")

# Set bearer
token=$(echo $resp | jq ".access_token" | xargs echo)

BEARER=$token
export BEARER
echo "Set BEARER token: ...$(echo $BEARER | tail -c 20)"
