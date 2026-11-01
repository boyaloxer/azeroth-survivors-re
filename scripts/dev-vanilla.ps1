# Normal WoW 1.12.1 client (login, server, stock UI) — not Azeroth Survivors mode.
# Usage: .\scripts\dev-vanilla.ps1
# Requires WOW_DATA (same wow-data\Data as survivors) and a 1.12.1 server (e.g. vmangos, Warden off).

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

$CargoBin = Join-Path $env:USERPROFILE ".cargo\bin"
if (Test-Path $CargoBin) {
    $env:Path = "$CargoBin;$env:Path"
}

$Data = Join-Path $Root "wow-data\Data"
if (-not ((Test-Path (Join-Path $Data "terrain.MPQ")) -and (Test-Path (Join-Path $Data "patch.MPQ")))) {
    Write-Host "Game data missing - run scripts\extract-wow-data.ps1 or fetch-data.sh first."
    exit 1
}

$env:WOW_DATA = $Data
Write-Host "WOW_DATA=$Data"
Write-Host "Starting benilla (vanilla 1.12.1 client). Point Realmlist at your server."
& cargo run --release -p benilla
