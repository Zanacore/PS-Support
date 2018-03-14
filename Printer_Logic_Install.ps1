#Custom for each Client
$HomeURL = "https://zanacore.printercloud.com"
$AuthCode = "flnvx3"

#You should not need to edit below this line
$ClientName = "PrinterInstallerClient.msi"
$URLPath = $HomeURL + "/client/setup/$ClientName"
$TempPath = "C:\TempPath\"

#Test Temp Path before trying to download
If(!(Test-Path -path $TempPath)) {New-Item -path $TempPath -Itemtype Directory}

#Download the Client software
Invoke-WebRequest -Uri $URLPath -OutFile "C:\TempPath\PrinterInstallerClient.msi"

#Run the installer
& $TempPath$ClientName /qn HomeURL=$HomeURL Authorization_Code=$AuthCode
