#This will map the drive and prompt for Password. If you remove the credential then it will use the currently login user
#New-PSDrive -Name "S" -Root "\\Server01\Scripts" -Persist -PSProvider "FileSystem" -Credential "Domain\User"
New-PSDrive -Name "S" -Root "\\192.168.1.10\Zanacore" -Persist -PSProvider "FileSystem" -Credential "Zanacore\Jason"