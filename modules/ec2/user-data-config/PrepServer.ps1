<powershell>

$serverType=$args[0]

Set-Location "C:\Windows\system32"

$aws_secret_count = 0
while (!$password){
    # Add a 5 second timer before (re)trying
    Start-Sleep -Seconds 5
    
    # Get Instance Metadata
    $instanceId = Get-EC2InstanceMetadata -Category InstanceId
    $environmentName = Get-EC2Tag -Filter @{Name="resource-type";Values="instance"},@{Name="resource-id";Values=$InstanceId} | ? { $_.key -eq "Environment" } | Select -expand Value
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
# Invoke-Expression  ((New-Object System.Net.Webclient).DownloadString("https://raw.githubusercontent.com/ansible/ansible/38e50c9f819a045ea4d40068f83e78adbfaf2e68/examples/scripts/ConfigureRemotingForAnsible.ps1"))
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

function Create-EventLog
{
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

Create-EventLog

Create-AnsibleUser

# Where to upload CA cert from. We auto install it but leave it there for debugging
$certPath = "C:\Users\Public\Desktop\TRUST_ME.crt"

# Here doc is templated by terraform
@"
${private_root_ca_crt}
"@ > $certPath



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


$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)

$store.Add($cert)
$store.Close()

</powershell>
