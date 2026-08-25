# setup_env.ps1

# Placeholder script to create a Python virtual environment and install requirements
param(
    [string]$VenvDir = "venv"
)

Write-Host "Setting up Python virtual environment (placeholder)" -ForegroundColor Cyan

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "Python not found in PATH. Please install Python 3.10+ and re-run." -ForegroundColor Red
    exit 1
}

python -m venv $VenvDir
Write-Host "Created virtualenv in ./$VenvDir" -ForegroundColor Green

$activate = Join-Path -Path $VenvDir -ChildPath "Scripts\Activate.ps1"
Write-Host "To activate the venv run: .\$VenvDir\Scripts\Activate.ps1" -ForegroundColor Yellow

if (Test-Path "requirements.txt") {
    Write-Host "Installing requirements from requirements.txt" -ForegroundColor Cyan
    & "$VenvDir\Scripts\python.exe" -m pip install --upgrade pip
    & "$VenvDir\Scripts\python.exe" -m pip install -r requirements.txt
} else {
    Write-Host "No requirements.txt found — skipping pip install." -ForegroundColor Yellow
}
