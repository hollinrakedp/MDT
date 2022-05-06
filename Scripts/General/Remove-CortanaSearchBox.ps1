<#
.SYNOPSIS
Removes the Cortana Seach Box from the taskbar.

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Remove Cortana Search Box
    PowerShell script: %SCRIPTROOT%\General\Remove-CortanaSearchBox.ps1

.NOTES
Name            : Remove-CortanaSearchBox.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f
reg unload "HKU\TEMP"