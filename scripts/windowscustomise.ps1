<powershell>
Set-Location "C:\Windows\system32"

#Install Chrome 
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

#Install Firefox 
$Path = $env:TEMP;
$Installer = "Firefox Setup 99.0.1.exe";
Invoke-WebRequest "https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=en-GB" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

Invoke-Expression ((New-Object System.Net.Webclient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))

# # Disable Internet Explorer Enhanced Security Configuration as its annoying. Then again Firefox and Chrome are installed
# function Disable-InternetExplorerESC {
#     $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
#     $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
#     Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
#     Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
# }

# Disable UAC i.e. the prompt everytime you want to install or change something
function Disable-UserAccessControl {
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 -Force   
}

# Disable Windows firewall for all profiles
function DisableWindowsFirewall {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
}

function Rename-instance {

    $instanceId = ( Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id -UseBasicParsing ).Content 

    $tags = Get-EC2Tag -Filter @( @{ name='resource-id'; values=$instanceId } )

    $name = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "DeviceId" } | select -expandProperty Value

    Rename-Computer -NewName $name

    if ($name.endswith("1")) 
	{
	 net user /add user1 $instanceId /Y
     net localgroup /add administrators user1
	 
	 net user /add user2 $instanceId /Y
	 net localgroup /add administrators user2
	}
        else 
        {
        net user /add user3 $instanceId /Y
        net localgroup /add administrators user3
	
	    net user /add user4 $instanceId /Y
        net localgroup /add administrators user4
        } 
}

function Chrome-Extension {

param(
    $extensionId="idgpnmonknjnojddfkpgkljpfnnfcklj",
    [switch]$info
)
if($info){
    $InformationPreference = "Continue"
}
if(!($extensionId)){
    # Empty Extension
    $result = "No Extension ID"
}
else{
    Write-Information "ExtensionID = $extensionID"
    $extensionId = "$extensionId;https://clients2.google.com/service/update2/crx"
    $regKey = "HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist"
    if(!(Test-Path $regKey)){
        New-Item $regKey -Force
        Write-Information "Created Reg Key $regKey"
    }
    # Add Extension to Chrome
    $extensionsList = New-Object System.Collections.ArrayList
    $number = 0
    $noMore = 0
    do{
        $number++
        Write-Information "Pass : $number"
        try{
            $install = Get-ItemProperty $regKey -name $number -ErrorAction Stop
            $extensionObj = [PSCustomObject]@{
                Name = $number
                Value = $install.$number
            }
            $extensionsList.add($extensionObj) | Out-Null
            Write-Information "Extension List Item : $($extensionObj.name) / $($extensionObj.value)"
        }
        catch{
            $noMore = 1
        }
    }
    until($noMore -eq 1)
    $extensionCheck = $extensionsList | Where-Object {$_.Value -eq $extensionId}
    if($extensionCheck){
        $result = "Extension Already Exists"
        Write-Information "Extension Already Exists"
    }else{
        $newExtensionId = $extensionsList[-1].name + 1
        New-ItemProperty HKLM:\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist -PropertyType String -Name $newExtensionId -Value $extensionId
        $result = "Installed"
    }
  }
}

function Desktop-URL
{
    $appnumber = "App"

    $httplink = "https://echo-app-0"

    $instanceId = ( Invoke-WebRequest -Uri http://169.254.169.254/latest/meta-data/instance-id -UseBasicParsing ).Content

    $tags = Get-EC2Tag -Filter @( @{ name='resource-id'; values=$instanceId } )
    
    $name = ( Get-EC2Instance -instance $instanceId )[0].RunningInstance[0].Tag |  Where-Object { $_.Key -eq "AppDomain" } | select -expandProperty Value

    $output = for ($i=1; $i -le 5; $i++) {

        echo "$appnumber $i - $httplink$i.$name"
    }

    $output | Set-Content -Path C:\Users\Public\Desktop\test-app-urls.txt
}

function Local-Admin
{
	 net user /add ansible QWErty1.2.3.4.5 /Y
     net localgroup /add administrators ansible
}

# Disable-InternetExplorerESC

Disable-UserAccessControl

DisableWindowsFirewall

Rename-instance

Chrome-Extension

Desktop-URL

Local-Admin

Restart-Computer

</powershell>