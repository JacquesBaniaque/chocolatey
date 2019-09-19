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
& choco install openjdk -y
& choco install docker-desktop -y
& choco install minikube -y

Write-Host "Press any key to continue..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
