# El Capulin - Windows 11 Setup Script

# Import utility functions
. "$PSScriptRoot\utils\check-admin.ps1"
. "$PSScriptRoot\utils\logging.ps1"

# Check if running as administrator
if (-not (Test-IsAdmin)) {
    Write-Error "This script must be run as Administrator"
    exit 1
}

# Import and run module scripts
$modules = @(
    "windows",
    "packages",
    "terminal",
    "dev"
)

foreach ($module in $modules) {
    Write-Log "Setting up $module..."
    try {
        . "$PSScriptRoot\modules\$module.ps1"
    } catch {
        Write-Error "Failed to import module: $module"
        Write-Error $_.Exception.Message
        exit 1
    }
}

Write-Log "Setup completed successfully!"