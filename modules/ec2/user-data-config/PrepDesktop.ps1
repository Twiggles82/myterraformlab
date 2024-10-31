<powershell>

Set-Location "C:\Windows\system32"

$aws_secret_count = 0
while (!$password) {
  # Add a 5 second timer before (re)trying
  Start-Sleep -Seconds 5
    
  # Get Instance Metadata
  $instanceId = Get-EC2InstanceMetadata -Category InstanceId
  $environmentName = Get-EC2Tag -Filter @{Name = "resource-type"; Values = "instance" }, @{Name = "resource-id"; Values = $InstanceId } | ? { $_.key -eq "Environment" } | Select -expand Value
  $ansibleCredentials = Get-SECSecretValue -SecretId "$($environmentName)-ansible" -Select SecretString | ConvertFrom-Json 

  # Ansible Credentials
  $ansibleUsername = $ansibleCredentials.username
  $ansiblePassword = $ansibleCredentials.password 
  $password = ConvertTo-SecureString "$ansiblePassword" -AsPlainText -Force

  # Loop
  $aws_secret_count++
  # When it hits 5 retries, break the while loop
  if ($aws_secret_count -eq 5) { break }
} 

## Run Ansible for Windows config script
## reference explicit commit so if moved in repo - still accessible
#Invoke-Expression ((New-Object System.Net.Webclient).DownloadString("https://raw.githubusercontent.com/ansible/ansible/38e50c9f819a045ea4d40068f83e78adbfaf2e68/examples/scripts/ConfigureRemotingForAnsible.ps1"))
# Download the script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/ansible/ansible/38e50c9f819a045ea4d40068f83e78adbfaf2e68/examples/scripts/ConfigureRemotingForAnsible.ps1" -OutFile "ConfigureRemotingForAnsible.ps1"

# Run the script with the -ForceNewSSLCert parameter as we sysprep'ed the host after running packer.
.\ConfigureRemotingForAnsible.ps1 -ForceNewSSLCert

## Allow basic connections
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

## Create the ansible user - need to workout passing in a password.
# net user /add $ansibleUsername $ansiblePassword /Y
# net localgroup /add administrators $ansibleUsername

# Alternative method to create user
# $password = ConvertTo-SecureString "$ansiblePassword" -AsPlainText -Force
# New-LocalUser "$ansibleUsername" -Password $password -Description "ansible user" -ErrorAction stop
# Add-LocalGroupMember -Group "Administrators" -Member "$ansibleUsername" -ErrorAction stop

#Install Chrome 
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

function Create-EventLog {
  New-EventLog -LogName Application -Source "USZ Setup" 
}

Function Create-AnsibleUser {
  process {
    try {
      # Create the user
      New-LocalUser "$ansibleUsername" -Password $password -FullName "$ansibleUsername" -Description "ansible user" -ErrorAction stop
      Write-EventLog -LogName Application -Source "USZ Setup" -EntryType Information -EventId 1 -Message "$ansibleUsername local user crated"
      # Add new user to administrator group
      Add-LocalGroupMember -Group "Administrators" -Member "$ansibleUsername" -ErrorAction stop
      Write-EventLog -LogName Application -Source "USZ Setup" -EntryType Information -EventId 1 -Message "$ansibleUsername added to the local administrator group"
    }
    catch {
      $error_message = $_
      Write-EventLog -LogName Application -Source "USZ Setup" -EntryType Error -EventId 1 -Message "Creating local account failed. Username:- $ansibleUsername Hashed password:- $password Error :- $error_message "
    }
  }    
}

function Trust-CA($path) {

  $store_name = [System.Security.Cryptography.X509Certificates.StoreName]::"Root"
  $store_location = [System.Security.Cryptography.X509Certificates.Storelocation]::"LocalMachine"
  $store = New-Object -TypeName System.Security.Cryptography.X509Certificates.X509Store -ArgumentList $store_name, $store_location
  try {
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
  }
  catch [System.Security.Cryptography.CryptographicException] {
    Fail-Json -obj $result -message "Unable to open the store as it is not readable: $($_.Exception.Message)"
  }
  catch [System.Security.SecurityException] {
    Fail-Json -obj $result -message "Unable to open the store with the current permissions: $($_.Exception.Message)"
  }
  catch {
    Fail-Json -obj $result -message "Unable to open the store: $($_.Exception.Message)"
  }


  $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($path)

  $store.Add($cert)
  $store.Close()
}


Create-EventLog

Create-AnsibleUser

##############################################################
# Add user desktop elements if the server is a desktop server
##############################################################

# Where to upload CA cert from. We auto install it but leave it there for debugging
$certPath = "C:\Users\Public\Desktop\TRUST_ME.crt"

# Here doc is templated by terraform
@"
${private_root_ca_crt}
"@ > $certPath


Trust-CA($certPath)

$isrgrootx1Path = "C:\Users\Public\Desktop\isrgrootx1.crt"
curl https://letsencrypt.org/certs/isrgrootx1.pem -o $isrgrootx1Path

Trust-CA($isrgrootx1Path)

# Disable Internet Explorer Enhanced Security Configuration as its annoying. 
$AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
$UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force

# Create application file on the desktop
# Prefix app names
$springsamlappname = "spring-saml-web"
$apertusappname = "apertus-portal"
$kciappname = "kci0"
$kcihttplink = "https://kci0"
$appname = "echo-app-0"
$httplink = "https://echo-app-0"
$heritageappname = "heritage-demoapp-01"

# Retrieve this instances metadata
[string]$token = Invoke-RestMethod -Headers @{"X-aws-ec2-metadata-token-ttl-seconds" = "21600" } -Method PUT -Uri http://169.254.169.254/latest/api/token

# Get the instance ID
$instanceId = (Invoke-RestMethod -Headers @{"X-aws-ec2-metadata-token" = $token } -Method GET -Uri http://169.254.169.254/latest/meta-data/instance-id)
$tags = Get-EC2Tag -Filter @( @{ name = 'resource-id'; values = $instanceId } )
    
# What is the domain - to use to append to the echo app URL
$name = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "AppDomain" } | select -expandProperty Value

# What is the domain - to use to append to the echo app URL
$name = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "AppDomain" } | select -expandProperty Value

# What is the CAG domain - to use to template the CagInfo.json file
$CagDomain = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "CagDomain" } | select -expandProperty Value

# What is the CAG Zone - to use to template the CagInfo.json file
$CagZone = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "CagZone" } | select -expandProperty Value

# Create all echo URLS
$output = for ($i = 1; $i -le 6; $i++) {
  echo "$appname$i - $httplink$i.$name"
}

# Create all kci URLS
$kciappoutput = for ($i = 1; $i -le 6; $i++) {
  echo "$kciappname$i - $kcihttplink$i.$name"
}

# Write to a new file on the desktop
Set-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "Kci Apps`n"

# Append Kci apps to the file
Add-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "kci   - https://kci.$name/home`n"
$kciappoutput | Add-Content -Path "C:\Users\Public\Desktop\test-app-urls.txt"

# Append Echo apps to the file
Add-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "`nEcho Apps`n"
$output | Add-Content -Path "C:\Users\Public\Desktop\test-app-urls.txt"

# Append heritage demo app to the file
Add-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "`nHeritage Demo App   - https://$heritageappname.$name/`n"

# Append Apertus Portal app to the file
Add-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "`nApertus Portal   - https://$apertusappname.$name/`n"

# Append spring saml web app to the file
Add-Content -Path C:\Users\Public\Desktop\test-app-urls.txt "`nSpring Saml Web   - https://$springsamlappname.$name/`n"

# Create a script on the desktop to download the automated testing package and template the files
echo '# Enter the parameters of the S3 Bucket name with the test file in and the name of the ip3a tar file' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo 'param ($BucketName, $TestFile)' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo 'Import-Module AWSPowerShell' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo 'Install-Package  7Zip4PowerShell -Force -Scope CurrentUser' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo 'Copy-S3Object -BucketName $BucketName -Key $TestFile -LocalFile $home\Desktop\$TestFile' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo 'Expand-7Zip $home\Desktop\$TestFile $home\Desktop' | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
echo ('Invoke-Expression ("$home\Desktop\ip3a-testing\template-scripts\template-desktop-files.ps1 -appDomain ' + $name + ' -CagDomain ' + $CagDomain + ' -CagZone ' + $CagZone + '")') | Add-Content -Path "C:\Users\Public\Desktop\prepare-integration-tests.ps1"
 
# Download files
New-Item -Path 'C:\Users\Public\Desktop\pythonInstall' -ItemType Directory

curl https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe -o "C:\Users\Public\Desktop\pythonInstall\python-3.11.9-amd64.exe"

# Install python
C:\Users\Public\Desktop\pythonInstall\python-3.11.9-amd64.exe /quiet InstallAllUsers=1 PrependPath=1 TargetDir="C:\Python311" "C:\Users\Public\Desktop\pythonInstall\Python311-Install.log"

# Wait to install before pip
Start-Sleep -Seconds 90 

# Add python to path
$Env:PATH += ";C:\Python311;C:\Users\Public\Desktop\pythonInstall\"

# Where to upload requirements.txt to
$requirementsPath = "C:\Users\Public\Desktop\pythonInstall\requirements.txt"

# Here doc is templated by terraform
@"
${requirements_txt}
"@ > $requirementsPath

## Install pip packages
py -m pip install -r $requirementsPath 

# Install playwirght - need to launch a new shell
Start-Process powershell "-command playwright install" 

</powershell>
