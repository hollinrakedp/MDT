<#
.SYNOPSIS
Removes OneDrive from the system and prevents it from installing on a per-user basis.

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Remove OneDrive
    PowerShell script: %SCRIPTROOT%\General\Remove-OneDrive.ps1

.NOTES
Name            : Remove-OneDrive.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

Get-Process -Name "OneDrive" | Stop-Process
if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    # Uninstall OneDrive for the currently logged on user
    Start-Process -FilePath "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait

    # Remove the installer from the system
    takeown /F "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" /A
    icacls "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" /Grant Administrators:`(F`)
    Remove-Item "$env:SystemDrive\Windows\SysWOW64\OneDriveSetup.exe" -Force
    Remove-Item "$env:ProgramData\Microsoft OneDrive" -Recurse -Force
}

# Stop RunOnce from launching the installer
reg load "HKLM\WIM" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg delete "HKLM\WIM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v OneDriveSetup /f
reg unload "HKLM\WIM"

# Remove Explorer link
reg add "HKCR\CLSID{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0 /f

# Remove Start Menu link
Remove-Item -Force "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

# Remove Scheduled Task
Get-ScheduledTask -TaskName "OneDrive*" | Unregister-ScheduledTask -Confirm:$false