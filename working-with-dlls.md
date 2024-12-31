to see what DLLs are loaded in a PowerShell process:

```powershell
$process = Get-Process -Name powershell
$process.Modules
$modules | Select-Object ModuleName
```
