# Base Configuration for All Systems

# Global Variables
$DOTFILES_DIR = $PSScriptRoot
$CONFIG_DIR = "$DOTFILES_DIR\config"
$SCRIPTS_DIR = "$DOTFILES_DIR\scripts"
$LOGS_DIR = "$DOTFILES_DIR\logs"

# Common Functions
function Initialize-BaseSystem {
    param(
        [string]$SystemType
    )
    
    Write-Host "Initializing base system configuration for $SystemType"
    
    # Create necessary directories
    $directories = @($CONFIG_DIR, $SCRIPTS_DIR, $LOGS_DIR)
    foreach ($dir in $directories) {
        if (-not (Test-Path -Path $dir)) {
            New-Item -ItemType Directory -Path $dir | Out-Null
        }
    }
}

function Get-SystemType {
    if ($IsWindows -or $ENV:OS -match "Windows") {
        return "windows"
    }
    elseif ($IsMacOS) {
        return "macos"
    }
    elseif ($IsLinux) {
        # Detect specific Linux distribution
        if (Test-Path "/etc/os-release") {
            $osRelease = Get-Content "/etc/os-release" | ConvertFrom-StringData
            return $osRelease.ID.ToLower()
        }
        return "linux"
    }
    return "unknown"
}

function Import-SystemModule {
    param(
        [string]$SystemType
    )
    
    $systemModulePath = "$DOTFILES_DIR\system\$SystemType\setup.ps1"
    if (Test-Path $systemModulePath) {
        . $systemModulePath
        return $true
    }
    return $false
}