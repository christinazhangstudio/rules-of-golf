PROMPT_DIRTRIM=1

## WSL
MOUNTEDGOPATH=/mnt/c/Users/chrzhang/go
alias gotogopath='cd $MOUNTEDGOPATH; ls'

# cover ./path/to/test/pkg/...
alias cover='f() { go test -v -coverprofile /tmp/cover.out "$1"; go tool cover -html /tmp/cover.out -o /tmp/cover.html; open /tmp/cover.html; }; f'

alias lint='golangci-lint run --config ./relative/path/to/golangci.yaml ./...'

alias kcat='kafkacat'

alias kc='kubectl'
alias kx='kubectx'



# it's really nice to have a scripts folder so this file isn't so cluttered
SCRIPTFOLDER=~/myscripts
alias bearer='. $SCRIPTFOLDER/bearer.sh'
###################################################
# #!/bin/bash

# url='<SSO_ENDPOINT>'

# CLIENT_SECRET=<CLIENT_SECRET>
# CLIENT_ID=<CLIENT_ID>
# GRANT_TYPE='client_credentials'
# RESOURCE='<SSO_RESOURCE>'

# resp=$(curl -s -X POST -d "client_secret=$CLIENT_SECRET&client_id=$CLIENT_ID&grant_type=$GRANT_TYPE&resource=$RESOURCE" -H "Content-Type: application/x-www-form-urlencoded" "$url")

# # Set bearer
# token=$(echo "$resp" | jq ".access_token" | xargs echo)

# BEARER=$token
# export BEARER
# echo "Set BEARER token: ...$(echo "$BEARER" | tail -c 20)"
###################################################
