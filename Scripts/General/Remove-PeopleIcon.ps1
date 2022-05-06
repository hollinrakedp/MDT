<#
.SYNOPSIS
Removes the People Icon from the taskbar.

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Remove People Icon
    PowerShell script: %SCRIPTROOT%\General\Remove-PeopleIcon.ps1

.NOTES   
Name            : Remove-PeopleIcon.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f
reg unload "HKU\TEMP"