<# Execute like:
.\give_all_permissions_to_folder_and_childs.ps1 C:\Users\Daniel\Desktop\Flutter\
or
.\give_all_permissions_to_folder_and_childs.ps1 "C:\Users\Daniel\Desktop\Flutter\"
#>

param([string]$path=$(throw "You must specify your name"))      ## PowerShell command-line parameters
# $path = "C:\Users\Daniel\Desktop\Flutter\"
Write-Host "Printing path variable" -ForegroundColor Green
Write-Output $path
$name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "Printing path_name" -ForegroundColor Green
Write-Output $name
$acl = Get-Acl $path
Write-Host "Printing permissions" -ForegroundColor Green
Write-Output $acl
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($name,"FullControl","Allow")
$acl.SetAccessRule($accessRule)
$acl | Set-Acl $path
Get-ChildItem -Path "$path" -Recurse -Force | Set-Acl -aclObject $acl -Verbose