#!/usr/bin/env pwsh

#This section pharses the /etc/os-release file and sets the $Environment variable 
$LinuxInfo = Get-Content /etc/os-release | ConvertFrom-StringData
$Environment = @()
$Environment += @{'LinuxInfo' = $LinuxInfo}
$Environment += @{'IsUbuntu' = $LinuxInfo.Id -match 'ubuntu'}
$Environment += @{'IsUbuntu14' =  $Environment.IsUbuntu -and $LinuxInfo.VERSION_ID -match '14.04'}
$Environment += @{'IsUbuntu16' =  $Environment.IsUbuntu -and $LinuxInfo.VERSION_ID -match '16.04'}
$Environment += @{'IsUbuntu18' =  $Environment.IsUbuntu -and $LinuxInfo.VERSION_ID -match '18.04'}
$Environment += @{'IsUbuntu1910' =  $Environment.IsUbuntu -and $LinuxInfo.VERSION_ID -match '19.10'}
$Environment += @{'IsCentOS' = $LinuxInfo.Id -match 'centos'}
$Environment += @{'IsFedora' = $LinuxInfo.Id -match 'fedora'}
$Environment += @{'IsOpenSUSE' = $LinuxInfo.Id -match 'opensuse'}
$Environment += @{'IsOpenSUSE13' = $Environment.IsOpenSUSE -and $LinuxInfo.VERSION_ID -match '13'}
$Environment += @{'IsOpenSUSE42.1' = $Environment.IsOpenSUSE -and $LinuxInfo.VERSION_ID -match '42.1'}
$Environment += @{'IsRedHatFamily' = $Environment.IsCentOS -and $Environment.IsFedora}

#This section checks if the system is ubuntu based
if($Environment.IsUbuntu){
    Write-Host "An Ubuntu based distro detected..."
    #Uncomment the below line to use apt to install your favorite application
    #sudo apt install 
}

#This section checks if the system is ubuntu 19.10
if($Environment.IsUbuntu1910){
    Write-Host 'An Ubuntu 19.10 based distro detected...'
    #Here we can add code to do something specific to ubuntu 19.10
}

#This section checks if the system is fedora based
if($Environment.IsFedora){
    Write-Host "An Fedora based distro detected..."
    #Uncomment the below line to use apt to install your favorite application
    #sudo dnf install 
}

