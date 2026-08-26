# Fix encoding helper (description)

This script (fix_encoding_safe.ps1) scans repository files with common text extensions and converts them to UTF-8 (without BOM by default). It creates backups in .encoding_backups/ before overwriti[...]

Usage:
- Dry run (no changes):
  powershell -ExecutionPolicy Bypass -File .\fix_encoding_safe.ps1 -RootPath . -DryRun
- Convert in place:
  powershell -ExecutionPolicy Bypass -File .\fix_encoding_safe.ps1 -RootPath .
- Convert and keep BOM:
  powershell -ExecutionPolicy Bypass -File .\fix_encoding_safe.ps1 -RootPath . -KeepBOM

Backups are saved under .encoding_backups in the specified RootPath directory.
