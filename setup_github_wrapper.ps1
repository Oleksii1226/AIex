<#
setup_github_wrapper.ps1

Placeholder helper script to create a new GitHub repository and push local files.
This script supports two modes:
 - Use gh CLI (recommended): the user runs `gh auth login` before running this script.
 - Use a PAT: the script will prompt for a PAT (do NOT paste long-lived tokens into public places).

This is a safe placeholder: it will show the commands it would run and optionally run them.
#>

param(
    [string]$LocalPath = "C:\Users\$env:USERNAME\windows_mvp_wrapper_github_repo",
    [string]$RepoName = "windows-mvp-wrapper",
    [switch]$UseGhCli
)

function Show-Note($msg){ Write-Host $msg -ForegroundColor Cyan }

Show-Note "Running setup_github_wrapper.ps1 (placeholder)"
Show-Note "Local path: $LocalPath"
Show-Note "Repo name: $RepoName"

# Prefer gh CLI if available
if ($UseGhCli -or (Get-Command gh -ErrorAction SilentlyContinue)) {
    Show-Note "Using gh CLI mode. Ensure you are authenticated: 'gh auth login'"
    Push-Location $LocalPath
    Show-Note "Creating repository with: gh repo create $RepoName --public --source=. --remote=origin --push"
    if ($PSCmdlet.ShouldProcess("gh repo create","create repo and push")) {
        gh repo create $RepoName --public --source=. --remote=origin --push
    }
    Pop-Location
    return
}

# Fallback: PAT mode (placeholder — do not store PAT persistently)
$pat = Read-Host -AsSecureString "Enter a GitHub PAT with repo scope (will not be stored)"
if (-not $pat) { Write-Warning "No PAT provided — aborting."; exit 1 }

# Convert secure string for temporary use
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pat)
$PlainPat = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

Show-Note "Creating remote repository via gh (if installed) or instructing manual curl commands"

# Minimal safe behavior: show commands to the user rather than making unauthenticated network calls in placeholder
Write-Host "Run the following commands manually in PowerShell (inside $LocalPath):" -ForegroundColor Yellow
Write-Host "  git init" -ForegroundColor Green
Write-Host "  git add ." -ForegroundColor Green
Write-Host "  git commit -m 'Initial commit: Windows MVP Wrapper'" -ForegroundColor Green
Write-Host "  git remote add origin https://github.com/<your_account>/$RepoName.git" -ForegroundColor Green
Write-Host "  git push -u origin main" -ForegroundColor Green

Write-Host "If you want the script to create the repo automatically, install 'gh' and run 'gh auth login', or re-run this script with -UseGhCli." -ForegroundColor Cyan
