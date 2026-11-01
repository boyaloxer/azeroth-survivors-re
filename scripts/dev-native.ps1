# Fast native playtest loop on Windows. Run from repo root in PowerShell:
#   .\scripts\dev-native.ps1
# First run downloads ~5.5 GB 1.12.1 MPQs via Git Bash (not the commercial AS client — needs terrain.MPQ).
# Requires: Git Bash, make (MSYS2 devkit or similar), Rust (rustup).

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

$CargoBin = Join-Path $env:USERPROFILE ".cargo\bin"
if (Test-Path $CargoBin) {
    $env:Path = "$CargoBin;$env:Path"
}

$Bash = Get-Command bash -ErrorAction SilentlyContinue
if (-not $Bash) {
    Write-Error "Git Bash not found. Install Git for Windows and ensure bash is on PATH."
}

$Data = Join-Path $Root "wow-data\Data"
if (-not ((Test-Path (Join-Path $Data "terrain.MPQ")) -and (Test-Path (Join-Path $Data "patch.MPQ")))) {
    Write-Host "Game data missing under wow-data\Data - run scripts\extract-wow-data.ps1 or fetch-data.sh first."
    exit 1
}

Write-Host "Repo: $Root"
$env:WOW_DATA = $Data
Write-Host "WOW_DATA=$Data"
Write-Host "Starting warcraft-survivors (release) ..."
& cargo run --release -p warcraft-survivors
