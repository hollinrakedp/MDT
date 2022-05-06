<#
.SYNOPSIS
Removes PowerShell v2 from the system if it's installed.

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Remove PowerShell v2
    PowerShell script: %SCRIPTROOT%\General\Remove-PowerShellV2.ps1

.NOTES   
Name            : Remove-PowerShellV2.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

if ((Get-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root).State -ne "Disabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root
}