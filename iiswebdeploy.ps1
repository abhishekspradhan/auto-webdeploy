Import-Module Servermanager
Install-WindowsFeature -Name "Web-Server" -IncludeManagementTools
Set-Content -Path "C:\inetpub\wwwroot\Default.html" -Value "This is the server: $($env:COMPUTERNAME)!"
Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/9b9f4a6e-aef8-41e0-90db-bae1b0cf4e34/4ab93354cdff8991d91a9f40d022d450/dotnet-hosting-3.1.6-win.exe -outfile $env:temp\\dotnet-hosting-3.1.6-win.exe;  
Start-Process -Wait -FilePath $env:temp\\dotnet-hosting-3.1.6-win.exe -Argument "/silent" -PassThru
Invoke-WebRequest https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi -outfile $env:temp\\WebDeploy_amd64_en-US.msi;  
Start-Process -Wait -FilePath $env:temp\\WebDeploy_amd64_en-US.msi -Argument "/quiet" -PassThru 
net stop was /y; 
net start w3svc
Install-WindowsFeature  Web-Mgmt-Service
Set-ItemProperty -Path  HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement  -Value 1
Set-Service -name WMSVC  -StartupType Automatic
Start-service WMSVC
