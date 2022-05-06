<#
.SYNOPSIS
Disables telemetry on the system

.DESCRIPTION
Add to the task sequence during the 'State Restore' section.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Disable Telemetry
    PowerShell script: %SCRIPTROOT%\General\Set-TelemetryDisabled.ps1

.NOTES   
Name            : Set-TelemetryDisabled.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /f /t REG_DWORD /v AllowTelemetry /d 0