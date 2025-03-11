## Get-ChildItem

To find something anywhere:
```powershell
Get-ChildItem -Path "C:\" -Filter "*.exe" -Recurse -File
```

## Unsetting an env permanently
```
Remove-Item Env:GOWORK
```

## Using `&`

### When invoking something at a path:

```powershell
& "C:\path\to\exe"
```
not needed for curr dir or something on `PATH`

### When invoking something at a path with an env var interpolated:
```powershell
& $env:HELLO\CATSTART.exe
```
or

```powershell
& "$env:HELLO\CATSTART.exe"
```
or

```powershell
& "$env:HELLO\\CATSTART.exe"
```
or

```powershell
& { & "$env:HELLO\\CATSTART.exe" }
```
or

```powershell
 & { & $env:HELLO\\CATSTART.exe }
```


(wdw1)


### When running command block:

```powershell
& { command-block }
```


## Using `-Command`

for when you want to execute PowerShell commands from outside a PowerShell session
(such as from a command prompt, batch script, or another process).


```powershell
powershell.exe -Command "Get-Process"
```

```powershell
powershell.exe -Command "&{ & '$env:HELLO\CATSTART.exe' }"
```

It has to be single quotes when used in `"&{ }"`! see wdw(2)


## When Powershell is giving you a hard time with path fmt:

```powershell
powershell.exe Get-ChildItem -Path "'C:\\Program Files\\Go\\bin'"
```


----
What doesn't work (wdw)
(1) 

```powershell
& { $env:HELLO\\CATSTART.exe}
```
```
At line:1 char:15
+ & { $env:HELLO\\CATSTART.exe}
+               ~~~~~~~~~~~~~~
Unexpected token '\\CATSTART.exe' in expression or statement.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : UnexpectedToken
```


```powershell
& { '$env:HELLO\\CATSTART.exe' }
$env:HELLO\\CATSTART.exe
```

```powershell
& { "$env:HELLO\CATSTART.exe" }
C:\Program Files\...\bin\\CATSTART.exe
```

```powershell
& { "$env:HELLO\\CATSTART.exe" }
C:\Program Files\...\bin\\CATSTART.exe
```

It has to be single quotes when used in `"&{ }"`!

(2)
```powershell
powershell -Command &{ & '$env:HELLO\CATSTART.exe' }
```
```
At line:1 char:21
+ powershell -Command &{ & '$env:HELLO\CATSTART.exe' }
+                     ~
The ampersand (&) character is not allowed. The & operator is reserved for future use; wrap an ampersand in double quotation marks ("&") to pass
it as part of a string.
```


```powershell
powershell -Command "&{ & "$env:HELLO\CATSTART.exe" }"
```
```
& : The term 'C:\Program' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name,
or if a path was included, verify that the path is correct and try again.
```

```powershell
powershell -Command "&{ & $env:HELLO\CATSTART.exe }"
```
```
& : The term 'C:\Program' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name,
or if a path was included, verify that the path is correct and try again.
```
It has to be single quotes when used in `"&{ }"`!
