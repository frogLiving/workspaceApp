# Purpose:  Citrix workspace installation
# Date:     7/26/2023

# Variables
$cPath = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\CitrixOnlinePluginPackWeb'

# Test to see if Citrix is installed
$a = Test-Path $cPath

if ($a) {
    $cApp = Get-ItemPropertyValue -Path $cPath -Name UninstallString

    # Split uninstall string for exe and Arguments
    $uninstallMe = $cApp -split "`""

    # Unisntall Citrix.  Adding "silent' switch
    echo "Removing Workspace"
    Start-Process $uninstallMe[1] -ArgumentList "$uninstallMe[2] /silent" -Wait
}

# Install Citrix workspace app
echo "Starting install"
$inst = Start-Process -FilePath CitrixWorkspaceApp.exe -ArgumentList "/silent /forceinstall /ALLOWADDSTORE=N /AutoUpdateCheck=disabled" -PassThru
$inst.WaitForExit()

# Pre-setup for setting registry keys
$keyName = @( 'Tw2IgnoreValidationErrors', 'Tw2IgnoreExecutionErrors')
$regKey = 'HKLM:\SOFTWARE\WOW6432Node\Citrix\ICA Client\Engine\Configuration\Advanced\Modules\Thinwire3.0'

# Test to see if the keys are present
try   { Get-ItemPropertyValue -Path $regKey -Name $keyName[1] -ErrorAction Stop }
catch { for ($i =0; $i -lt $keyName.count; $i++) { New-ItemProperty -Path $regKey -Name $keyName[$i] -Value TRUE } }