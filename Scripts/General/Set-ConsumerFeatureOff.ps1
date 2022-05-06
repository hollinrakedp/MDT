<#
.SYNOPSIS
Keeps the start menu clean by removing the consumer features.

.DESCRIPTION
Add to the task sequence during the 'State Restore' section.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Turn off Consumer Features
    PowerShell script: %SCRIPTROOT%\General\Set-ConsumerFeatureOff.ps1

.NOTES   
Name            : Set-ConsumerFeatureOff.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f