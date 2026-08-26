Param(
    [string]$RootPath = ".",
    [switch]$DryRun,            # якщо вказано - лише перевірка, без запису
    [switch]$KeepBOM = $false,  # якщо вказано - зберігати BOM у UTF-8 файлах
    [string[]]$Extensions = @(".ps1",".md",".json",".txt",".config",".ini",".yaml",".yml")
)

$backupsDir = Join-Path $RootPath ".encoding_backups"
if (-not (Test-Path $backupsDir)) { New-Item -ItemType Directory -Path $backupsDir | Out-Null }

$errors = @()
$converted = @()
$skipped = @()

function Has-NullByte([byte[]]$bytes) {
    foreach ($b in $bytes) { if ($b -eq 0) { return $true } }
    return $false
}

Get-ChildItem -Path $RootPath -Recurse -File | Where-Object {
    $Extensions -contains $_.Extension.ToLower()
} | ForEach-Object {
    $path = $_.FullName
    try {
        $bytes = [System.IO.File]::ReadAllBytes($path)
        if (Has-NullByte $bytes) {
            $skipped += @{ path=$path; reason="contains null byte (likely binary)" }
            return
        }

        # detect BOM
        $hasUtf8Bom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
        $hasUtf16LeBom = ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFF -and $bytes[1] -eq 0xFE)
        $hasUtf16BeBom = ($bytes.Length -ge 2 -and $bytes[0] -eq 0xFE -and $bytes[1] -eq 0xFF)

        # Try decode as UTF-8 first (lenient)
        try {
            $text = [System.Text.Encoding]::UTF8.GetString($bytes)
            # Basic sanity: ensure not many replacement chars � (U+FFFD)
            $badCount = ($text.ToCharArray() | Where-Object { [int]$_ -eq 0xFFFD }).Count
            if ($badCount -gt [math]::Max(1, [math]::Floor($text.Length * 0.01))) {
                throw "Too many replacement chars — likely wrong encoding"
            }
            $detected = "utf8"
        } catch {
            # Fallback: decode with system default (ANSI)
            $text = [System.Text.Encoding]::Default.GetString($bytes)
            $detected = "system-default"
        }

        # If DryRun - only report
        if ($DryRun) {
            $converted += @{ path=$path; detected=$detected; bomUtf8=$hasUtf8Bom; action="dryrun-skip" }
            return
        }

        # Backup original
        $rel = Resolve-Path -Path $path
        $bakName = [System.IO.Path]::GetFileName($path) + ".bak"
        $bakPath = Join-Path $backupsDir $bakName
        $i = 1
        while (Test-Path $bakPath) {
            $bakPath = Join-Path $backupsDir ("{0}.bak{1}" -f [System.IO.Path]::GetFileName($path), $i)
            $i++
        }
        Copy-Item -Path $path -Destination $bakPath -Force

        # Prepare UTF8 bytes (optionally keep BOM)
        if ($KeepBOM) {
            $utf8Enc = New-Object System.Text.UTF8Encoding($true)  # emit BOM
        } else {
            $utf8Enc = New-Object System.Text.UTF8Encoding($false) # no BOM
        }
        $outBytes = $utf8Enc.GetBytes($text)
        [System.IO.File]::WriteAllBytes($path, $outBytes)

        $converted += @{ path=$path; detected=$detected; bomUtf8=$hasUtf8Bom; backup=$bakPath }
    } catch {
        $errors += @{ path=$path; error=$_.Exception.Message }
    }
}

Write-Host "`nSummary:`n" -ForegroundColor Cyan
Write-Host "Converted: $($converted.Count)" -ForegroundColor Green
foreach ($c in $converted) { Write-Host "  + $($c.path) (detected: $($c.detected))" }

Write-Host "`nSkipped: $($skipped.Count)" -ForegroundColor Yellow
foreach ($s in $skipped) { Write-Host "  - $($s.path) : $($s.reason)" }

if ($errors.Count -gt 0) {
    Write-Host "`nErrors: $($errors.Count)" -ForegroundColor Red
    foreach ($e in $errors) { Write-Host "  ! $($e.path) : $($e.error)" }
} else {
    Write-Host "`nNo conversion errors." -ForegroundColor Green
}

Write-Host "`nBackups saved to: $backupsDir" -ForegroundColor Cyan
