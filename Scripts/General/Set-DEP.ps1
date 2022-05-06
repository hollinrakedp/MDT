<#
.SYNOPSIS
Set Data Execution Prevention (DEP) to OptOut.

.DESCRIPTION
Add to the task sequence during the 'State Restore' section.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Set DEP to OptOut
    PowerShell script: %SCRIPTROOT%\General\Set-DEP.ps1

.NOTES   
Name            : Set-DEP.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 

#>

# Get current DEP configuration and change to OptOut if needed
$DEPValue = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object DataExecutionPrevention_SupportPolicy

if ($DEPValue.DataExecutionPrevention_SupportPolicy -ne 3) {
    BCDEDIT /set "{current}" nx OptOut
}