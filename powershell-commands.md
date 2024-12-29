## Using `&`

When invoking something at a path:

```sh
& "C:\path\to\exe"
```
not needed for curr dir or something on `PATH`

When running command block:
```sh
& { command-block }
```


## Using `-Command`

for when you want to execute PowerShell commands from outside a PowerShell session
(such as from a command prompt, batch script, or another process).

```sh
powershell.exe -Command "Get-Process"
```


## When Powershell is giving you a hard time with path fmt:

```sh
powershell.exe Get-ChildItem -Path "'C:\\Program Files\\Go\\bin'"
```

