<#
bootstrap_win.ps1

Placeholder Windows bootstrap script.
Intended to install optional helpers (chocolatey) and system prerequisites.
Run as Administrator when performing system installs.
#>

Write-Host "Bootstrap (placeholder) — check system prerequisites" -ForegroundColor Cyan

# Check for chocolatey
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found. This placeholder will not auto-install it. To install, run as admin:" -ForegroundColor Yellow
    Write-Host "Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" -ForegroundColor Green
} else {
    Write-Host "Chocolatey found." -ForegroundColor Green
}

# Example: ensure Git and Python are installed (informational only)
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Write-Host "Git not found — please install Git." -ForegroundColor Red }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { Write-Host "Python not found — please install Python 3.10+ and add to PATH." -ForegroundColor Red }

Write-Host "Bootstrap placeholder finished. Edit this file to add real install steps for your environment." -ForegroundColor Cyan
