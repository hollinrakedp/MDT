<#
.SYNOPSIS
Adds custom tattoo items to the registry and create a text file at the root of the system drive with build information. Includes the Task Sequence Name, Version, and Build Date.

.DESCRIPTION
Add to the task sequence during the 'State Restore' section.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Custom Tattoo and Build Info File
    PowerShell script: %SCRIPTROOT%\General\Set-CustomTattoo.ps1

.NOTES   
Name            : Set-CustomTattoo.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 
#>

# Add Date of Capture registry key
reg add "HKLM\SOFTWARE\Microsoft\Deployment 4" /v "Capture Date" /t REG_SZ /d (Get-Date -Format yyyy-MM-dd)

# Create a build file
if (!(Test-Path "$env:SystemDrive\buildinfo.txt")) {
    New-Item -ItemType "file" -Path "$env:SystemDrive\buildinfo.txt"
}

$TaskSequenceName = "Release:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Task Sequence Name"
$TaskSequenceVersion = "Version:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Task Sequence Version"
$BuildDate = "Build Date:`t" + (Get-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Deployment 4")."Capture Date"

$TaskSequenceName | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
$TaskSequenceVersion | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append
$BuildDate | Out-File -FilePath "$env:SystemDrive\buildinfo.txt" -Append