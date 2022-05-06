<#
.SYNOPSIS
Set the registry keys necessary to mitigate speculative execution vulnerabilities.

.DESCRIPTION
Add to the task sequence during the 'State Restore' section.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Speculative Execution Mitigation
    PowerShell script: %SCRIPTROOT%\General\Set-SpeculativeExecution.ps1

.NOTES   
Name            : Set-SpeculativeExecution.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 72 /f
