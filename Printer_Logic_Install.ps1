﻿#This script must be ran as Administrator
#Custom for each Client
$HomeURL = "https://client.printercloud.com"
$AuthCode = "code"

#You should not need to edit below this line
$ClientName = "PrinterInstallerClient.msi"
$URLPath = $HomeURL + "/client/setup/$ClientName"
$TempPath = "C:\TempPath\"

function Use-RunAs 
{    
    # Check if script is running as Adminstrator and if not use RunAs 
    # Use Check Switch to check if admin 
     
    param([Switch]$Check) 
     
    $IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()` 
        ).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator") 
         
    if ($Check) { return $IsAdmin }     
 
    if ($MyInvocation.ScriptName -ne "") 
    {  
        if (-not $IsAdmin)  
        {  
            try 
            {  
                $arg = "-file `"$($MyInvocation.ScriptName)`"" 
                Start-Process "$psHome\powershell.exe" -Verb Runas -ArgumentList $arg -ErrorAction 'stop'  
            } 
            catch 
            { 
                Write-Warning "Error - Failed to restart script with runas"  
                break               
            } 
            exit # Quit this session of powershell 
        }  
    }  
    else  
    {  
        Write-Warning "Error - Script must be saved as a .ps1 file first"  
        break  
    }  
} 

Use-RunAs

#Test Temp Path before trying to download
If(!(Test-Path -path $TempPath)) {New-Item -path $TempPath -Itemtype Directory}

#Download the Client software
Invoke-WebRequest -Uri $URLPath -OutFile "C:\TempPath\PrinterInstallerClient.msi"

#Run the installer
& $TempPath$ClientName /qn HomeURL=$HomeURL Authorization_Code=$AuthCode