to see what DLLs are loaded in a PowerShell process:

```sh
$process = Get-Process -Name powershell
PS C:\caa_app\B423\win_b64\code\bin> $modules = $process.Modules
PS C:\caa_app\B423\win_b64\code\bin> $modules | Select-Object ModuleName
```
