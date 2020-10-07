$here = Split-Path -parent $MyInvocation.MyCommand.Definition
$script = $MyInvocation.MyCommand.Name

$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Not running with administrative rights. Attempting to elevate..."
    $command = "-ExecutionPolicy bypass -File `"$here\$script`""
    Start-Process powershell -verb runas -argumentlist $command
    Exit
}

Write-Host "`n========= Updating chocolatey... ========="
& choco install googlechrome -y
& choco install git -y
& choco install putty -y
& choco install 7zip -y
& choco install postman -y
& choco install openjdk --allow-multiple -y
& choco install openjdk --allow-multiple --version 11.0.2.01 -y
& choco install openjdk --allow-multiple --version 15.0.0 -y
& choco install docker-desktop -y
& choco install minikube -y
& choco upgrade -y all

Write-Host "Press any key to continue..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
