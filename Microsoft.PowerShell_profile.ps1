######## ENV VARS ######
Set-Variable -Name "EXAMPLE_ENV" -Value "itschristina"

##### BEARER TOKEN ######
function BearerFunc{
	$body = @{client_secret="<CLIENT_SECRET>"
      		client_id="<CLIENT_ID>"
      		grant_type="client_credentials"
      		resource="<SSO_RESOURCE>"}
	$contentType = 'application/x-www-form-urlencoded' 
	$resp = Invoke-RestMethod -Method POST -Uri "<SSO_ENDPOINT .../adfs/oauth2/token>" -body $body -ContentType $contentType
	Set-Variable -Name "BEARER" -Value $resp.access_token
	$Global:BEARER = $resp.access_token 
	echo $BEARER
}

Set-Alias -Name bearer -Value BearerFunc


######## GOTO ########

function GoToGoPathFunc {
	Set-Location "C:/Users/chrzhang/go"
	Get-ChildItem	
}

Set-Alias gotogopath GoToGoPathFunc

######## FORMAT PATH ON CONSOLE #######

function prompt {
    $currentPath = (Get-Location).Path
    $trimmedPath = (Split-Path $currentPath -Leaf)
    "$trimmedPath> "
}


