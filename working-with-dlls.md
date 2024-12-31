to see what DLLs are loaded in a PowerShell process:

```powershell
$process = Get-Process -Name powershell
$process.Modules
$modules | Select-Object ModuleName
```

To see everything on the current system, remove `-Name powershell`

This should implicitly tell you if the system can at least locate DLL's, I think.

```
$modules | findstr
```

to find specific stuff
