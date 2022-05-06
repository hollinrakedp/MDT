<#
.SYNOPSIS
Removes the News and Features Icon from the taskbar.

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Remove News and Interests icon
    PowerShell script: %SCRIPTROOT%\General\Remove-TaskViewIcon.ps1

.NOTES
Name            : Remove-NewsInterestsIcon.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg load "HKU\TEMP" "$env:SystemDrive\Users\Default\NTUSER.DAT"
reg add "HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
reg unload "HKU\TEMP"