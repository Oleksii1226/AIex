<#
windows_run_wrapper.ps1

Placeholder runner script that:
 - Ensures logs/ exists
 - Checks for Python and virtualenv
 - Activates venv (if present) and runs orchestrator.py
 - Streams output to logs/windows_run_wrapper.log

This is a minimal example — adapt to your orchestrator and model paths.
#>

$LogDir = "logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir | Out-Null }
$WrapperLog = Join-Path $LogDir "windows_run_wrapper.log"

function Log($msg){ $ts = Get-Date -Format o; "$ts`t$msg" | Out-File -FilePath $WrapperLog -Append }

Log "Starting windows_run_wrapper (placeholder)"

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Log "ERROR: python not found in PATH"
    Write-Host "ERROR: python not found in PATH" -ForegroundColor Red
    exit 1
}

# If venv exists, use it
$VenvPython = "venv\Scripts\python.exe"
if (Test-Path $VenvPython) {
    Log "Using virtualenv python: $VenvPython"
    $PythonExe = $VenvPython
} else {
    Log "Using system python"
    $PythonExe = "python"
}

# Ensure orchestrator.py exists
if (-not (Test-Path "orchestrator.py")) {
    Log "ERROR: orchestrator.py not found"
    Write-Host "ERROR: orchestrator.py not found" -ForegroundColor Red
    exit 1
}

# Start orchestrator and redirect output to log
$OrchLog = Join-Path $LogDir "orchestrator.log"
Log "Launching orchestrator.py"

# Start-process to run and wait
Start-Process -FilePath $PythonExe -ArgumentList "orchestrator.py" -NoNewWindow -RedirectStandardOutput $OrchLog -RedirectStandardError $OrchLog -Wait

Log "orchestrator.py finished (placeholder)"
Write-Host "Run complete — see logs in $LogDir" -ForegroundColor Green
