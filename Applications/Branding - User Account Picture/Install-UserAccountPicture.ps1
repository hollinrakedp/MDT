<#
.SYNOPSIS
Replaces the default User Account Picture images with ones you provide.

.DESCRIPTION
Import as a standard application in MDT.

Quiet install command:
    PowerShell.exe -ExecutionPolicy Bypass -NoProfile -Command .\Install-UserAccountPicture.ps1

For this script to work, you must provide the image files listed in the NOTES section.

.NOTES
Name            : Install-UserAccountPicture.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 

Create the following images:
    Name            Resolution
    ---------	    -------------
    user.bmp        448x448
    user.png        448x448
    user-32.png     32x32
    user-40.png     40x40
    user-48.png     48x48
    user-192.png    192x192

Place the images in the same folder as this script.

Due to the need to copy to a protected system location, files need to be transferred to a temporary location locally and then to their final destiantion.
#>

$LocalTemp = "$env:SystemDrive\temp\UserAccountPicture"
# Create the App Directory
if (!(Test-Path "$env:SystemDrive\$LocalTemp")) {
    New-Item -ItemType Directory -Path "$LocalTemp" -Force
}

# Copy the images to the local system
Copy-Item "$PSScriptRoot\*" "$LocalTemp" -Force -Recurse

# Take ownership of the existing account pictures
takeown /f "$env:ProgramData\Microsoft\User Account Pictures\*"

# Assign full permissions to the existing lock screen files to Administrators
& icacls "$env:ProgramData\Microsoft\User Account Pictures\*" /Grant Administrators:`(F`)

# Delete the existing files
Remove-Item "$env:ProgramData\Microsoft\User Account Pictures\user*"

# Copy our new lock screen files to the proper location
Copy-Item "$LocalTemp\*" "$env:ProgramData\Microsoft\User Account Pictures"

# Add the registry key to set the default account picture for all users
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v UseDefaultTile /t REG_DWORD /d 1

# Give ownership back to Trusted Installer
& icacls "$env:ProgramData\Microsoft\User Account Pictures\*" /setowner "NT SERVICE\TrustedInstaller"

# Cleanup temp files
Remove-Item -Path "$LocalTemp" -Recurse