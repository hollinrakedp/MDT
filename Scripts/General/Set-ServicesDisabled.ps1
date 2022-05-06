<#
.SYNOPSIS
Set unnecessary services to "Disabled".

.DESCRIPTION
Add to the task sequence during the 'State Restore' portion.

Add a new task: Add->General->Run PowerShell Script
    Type: PowerShell Script
    Name: Disable Services
    PowerShell script: %SCRIPTROOT%\General\Set-ServicesDisabled.ps1

.NOTES   
Name            : Set-ServicesDisabled.ps1
Author          : Darren Hollinrake
Version         : 1.0
Date Created    : 2022-05-01
Date Updated    : 

***Customization***
Add or remove services you want disabled to the $Services array.

***NOTE***
If you disable the services "dmwappushservice" and "wlidsvc", the first boot after installation is extremely slow.
#>

$Services = @("XblAuthManager",
              "XblGameSave",
              "XboxNetApiSvc",
              "xbgm",
              "bthserv",
              "BthHFSrv",
              "lfsvc",
              "Fax",
              "PhoneSvc",
              "icssvc",
              "MapsBroker",
              "WMPNetworkSvc",
              "RetailDemo",
              "RemoteAccess",
              "WalletService",
              "SharedAccess",
              "lltdsvc",
              "NcbService",
              "QWAVE",
              "RmSvc",
              "SSDPSRV",
              "FrameServer",
              "ALG",
              "WwanSvc",
              "WlanSvc",
              "AJRouter",
              "MSiSCSI",
              "WpcMonSvc",
              "WFDSConMgrSvc",
              "BTAGService")

# Retrieves the current startup type for the list of services
Get-Service $Services -ErrorVariable ServiceError | Out-Null
# Remove services that don't exist from the array
if ($ServiceError.Count -ne 0) {
    Write-Verbose "The following services did not exist:" ($($ServiceError.Exception.ServiceName) -join ', ')`r`n
    foreach ($i in $($ServiceError.Exception.ServiceName)) {
        Write-Output "Removing Service from list: $i"
        $Services = $Services | Where-Object { $_ -notin $i }
    }
}

# Stop and Disable the services
Get-Service $Services | Where-Object StartType -NE Disabled | Stop-Service -PassThru | Set-Service -StartupType Disabled -Verbose

# Using the above method for disabling this service fails with the message: Access denied
REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\xbgm"  /f /t REG_DWORD /v Start /d 4