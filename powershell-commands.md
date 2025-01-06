## Get-ChildItem

To find something anywhere:
```powershell
Get-ChildItem -Path "C:\" -Filter "*.exe" -Recurse -File
```

## Using `&`

When invoking something at a path:

```powershell
& "C:\path\to\exe"
```
not needed for curr dir or something on `PATH`

When invoking something at a path with an env var interpolated:
```
> { "$env:USER\\CATSTART.exe" }
\\CATSTART.exe
helm-charts> & { echo "$env:OMS_CATSTART_PATH\\CATSTART.exe" }
\\CATSTART.exe
helm-charts> & { echo "$env:USER\\CATSTART.exe" }
chrzhang\\CATSTART.exe
helm-charts> & { echo '$env:USER\\CATSTART.exe' }
$env:USER\\CATSTART.exe
```
(wdw1)


When running command block:

```powershell
& { command-block }
```


## Using `-Command`

for when you want to execute PowerShell commands from outside a PowerShell session
(such as from a command prompt, batch script, or another process).


```powershell
powershell.exe -Command "Get-Process"
```


## When Powershell is giving you a hard time with path fmt:

```sh
powershell.exe Get-ChildItem -Path "'C:\\Program Files\\Go\\bin'"
```


----
What doesn't work (wdw)
(1) 

```powershell
chrzhang> & { $env:HELLO\\CATSTART.exe}
At line:1 char:15
+ & { $env:HELLO\\CATSTART.exe}
+               ~~~~~~~~~~~~~~
Unexpected token '\\CATSTART.exe' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnexpectedToken

```powershell
chrzhang> & { $env:HELLO\CATSTART.exe}
At line:1 char:15
+ & { $env:HELLO\CATSTART.exe}
+               ~~~~~~~~~~~~~
Unexpected token '\CATSTART.exe' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnexpectedToken
```

```powershell
chrzhang> & { '$env:HELLO\\CATSTART.exe' }
$env:HELLO\\CATSTART.exe
```
