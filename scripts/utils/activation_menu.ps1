# Windows Activation Menu Module

function Show-ActivationMenu {
    Clear-Host
    Write-Host "Windows Activation Menu" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Activate Windows"
    Write-Host "2. Check Activation Status"
    Write-Host "3. Back to Main Menu"
    Write-Host ""
    
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "1" {
            Write-Host "\nAttempting Windows Activation..." -ForegroundColor Yellow
            $result = Invoke-WindowsActivation
            if ($result) {
                Write-Host "Press any key to continue..."
                $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            }
            Show-ActivationMenu
        }
        "2" {
            Clear-Host
            Write-Host "Current Activation Status:" -ForegroundColor Cyan
            Write-Host "======================" -ForegroundColor Cyan
            Write-Host ""
            $status = Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object { $_.PartialProductKey -and $_.Name -like "Windows*" }
            Write-Host "License Status: $($status.LicenseStatus)"
            Write-Host "Product Name: $($status.Name)"
            Write-Host ""
            Write-Host "Press any key to continue..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            Show-ActivationMenu
        }
        "3" {
            . "$PSScriptRoot\menu.ps1"
            Show-MainMenu
        }
        default {
            Write-Host "\nInvalid choice. Please try again." -ForegroundColor Red
            Start-Sleep -Seconds 2
            Show-ActivationMenu
        }
    }
}

# Export functions
Export-ModuleMember -Function Show-ActivationMenu