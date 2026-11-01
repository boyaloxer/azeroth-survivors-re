# Extract Data/*.MPQ from the archive.org 1.12.1 zip when Git Bash has no `unzip`.
# Usage: .\scripts\extract-wow-data.ps1
# Expects wow-data/1.12.1-5875_enUS.zip (from fetch-data.sh download).

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$DataDir = Join-Path $Root "wow-data"
$Zip = Join-Path $DataDir "1.12.1-5875_enUS.zip"
$OutData = Join-Path $DataDir "Data"

if ((Test-Path (Join-Path $OutData "terrain.MPQ")) -and (Test-Path (Join-Path $OutData "patch.MPQ"))) {
    Write-Host "MPQs already present at $OutData"
    exit 0
}

if (-not (Test-Path $Zip)) {
    Write-Error "Missing $Zip - run fetch-data.sh from Git Bash first (needs curl)."
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
New-Item -ItemType Directory -Force -Path $OutData | Out-Null

Write-Host "Extracting Data/*.MPQ from $(Split-Path -Leaf $Zip) ..."
$archive = [System.IO.Compression.ZipFile]::OpenRead($Zip)
try {
    foreach ($entry in $archive.Entries) {
        if ($entry.FullName -notmatch '^Data/.*\.MPQ$') { continue }
        $name = Split-Path -Leaf $entry.FullName
        $dest = Join-Path $OutData $name
        if (Test-Path $dest) {
            Write-Host "  skip $name"
            continue
        }
        Write-Host "  $name"
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $dest, $true)
    }
} finally {
    $archive.Dispose()
}

Write-Host "Done. Data at $OutData"
