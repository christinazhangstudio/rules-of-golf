@echo off
rem setlocal EnableDelayedExpansion is sometimes recommended, but seemingly not needed here

rem Vault login
set VAULT_ADDR="<VAULT_ADDR>"
vault login -address=%VAULT_ADDR% -method=ldap username=%USERNAME% >nul
if %ERRORLEVEL% neq 0 (
    echo failed to login to Vault
    exit /b 1
)

rem Vault vals
vault kv get -address=%VAULT_ADDR% -field=<kafka_cert> > kafka_cert.txt
vault kv get -address=%VAULT_ADDR% -field=<kafka_key> kafka_key.txt

rem Batch doesn't handle multiline vals well,
rem so we need to convert files to single-line Base64
rem read the encoded vals into env vars,
rem and clean up any temp files
powershell -Command "[convert]::ToBase64String([System.IO.File]::ReadAllBytes('kafka_cert.txt'))" > kafka_cert.b64
powershell -Command "[convert]::ToBase64String([System.IO.File]::ReadAllBytes('kafka_key.txt'))" > kafka_key.b64
if %ERRORLEVEL% neq 0 (
    echo failed to encode vault vals
    goto :cleanup
)

set /p KAFKA_WRITER_SSL_CRT_B64=<kafka_cert.b64
set /p KAFKA_WRITER_SSL_KEY_B64=<kafka_key.b64

:cleanup
del kafka_cert.txt kafka_key.txt kafka_cert.b64 kafka_key.b64

rem Batch special chars so `set`, can also wrap in quotes (see below)
set MYSQL_DSN_URL="tcp(<blah>)/<blah>&tls=false"

rem build image
docker build ^
  -t <docker-tag> ^
  -f <Dockerfile> ^
  .

docker run ^
    --rm --name <docker-tag> ^
    --env SOME_BOOL=true ^
    --env SOME_INT=1000000000 ^
    --env SOME_VAR=%JWT_CLIENT_ID% ^
    --env MYSQL_DSN_URL=%MYSQL_DSN_URL% ^
    --env KAFKA_WRITER_SSL_CRT_B64=%KAFKA_WRITER_SSL_CRT_B64% ^
    --env KAFKA_WRITER_SSL_KEY_B64=%KAFKA_WRITER_SSL_KEY_B64% ^
    --env "SOME_PATH=C:\somepath\some.exe" ^
    -p 9095:9095 <docker-tag>

pause
