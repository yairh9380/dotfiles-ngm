# Multi-System Installation Script

# Import base configuration
. "$PSScriptRoot\..\system\base\config.ps1"

function Start-SystemInstallation {
    # Detect system type
    $systemType = Get-SystemType
    Write-Host "Detected system type: $systemType"
    
    # Initialize base system
    Initialize-BaseSystem $systemType
    
    # Import and initialize system-specific module
    if (Import-SystemModule $systemType) {
        switch ($systemType) {
            "windows" { Initialize-WindowsSystem }
            "macos" { Initialize-MacOSSystem }
            "ubuntu" { Initialize-LinuxSystem "ubuntu" }
            "arch" { Initialize-ArchSystem }
            "debian" { Initialize-LinuxSystem "debian" }
            "fedora" { Initialize-LinuxSystem "fedora" }
            "kali" { Initialize-KaliSystem }
            "nixos" { Initialize-NixOSSystem }
            "linux" { Initialize-LinuxSystem }
            default {
                Write-Host "Unsupported system type: $systemType"
                return $false
            }
        }
        return $true
    }
    
    Write-Host "Failed to import system module for: $systemType"
    return $false
}

# Start the installation
$result = Start-SystemInstallation
if (-not $result) {
    Write-Host "Installation failed!"
    exit 1
}