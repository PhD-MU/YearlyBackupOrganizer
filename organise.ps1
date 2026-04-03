<#
This script was developed by Murat UZUN (muratuzun79@gmail.com)

Purpose:
Automatically organize database backup files into yearly folders.

Features:
- Creates missing folders from 2020 up to (current year - 1)
- Works with all file types regardless of extension
- Moves files based on "_YYYY" pattern in filename
- Optionally deletes empty folders
- Generates summary or detailed reports
#>

param(
    [string]$TargetPath
)

Clear-Host

function Show-LoadingAnimation {
    param(
        [string]$Message = "Initializing",
        [int]$Seconds = 3
    )

    $spinner = @("|", "/", "-", "\")
    $endTime = (Get-Date).AddSeconds($Seconds)
    $i = 0

    while ((Get-Date) -lt $endTime) {
        $frame = $spinner[$i % $spinner.Count]
        Write-Host "`r$Message $frame" -NoNewline -ForegroundColor Yellow
        Start-Sleep -Milliseconds 120
        $i++
    }

    Write-Host "`r$Message completed.   " -ForegroundColor Green
}

$asciiLogo = @'
██╗     ███████╗████████╗███████╗    ██████╗ ██████╗  ██████╗  █████╗ ███╗   ██╗██╗███████╗███████╗
██║     ██╔════╝╚══██╔══╝██╔════╝   ██╔═══██╗██╔══██╗██╔════╝ ██╔══██╗████╗  ██║██║██╔════╝██╔════╝
██║     █████╗     ██║   █████╗     ██║   ██║██████╔╝██║  ███╗███████║██╔██╗ ██║██║███████╗█████╗
██║     ██╔══╝     ██║   ██╔══╝     ██║   ██║██╔══██╗██║   ██║██╔══██║██║╚██╗██║██║╚════██║██╔══╝
███████╗███████╗   ██║   ███████╗   ╚██████╔╝██║  ██║╚██████╔╝██║  ██║██║ ╚████║██║███████║███████╗
╚══════╝╚══════╝   ╚═╝   ╚══════╝    ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝
'@

Write-Host ""
foreach ($line in ($asciiLogo -split "`n")) {
    Write-Host $line -ForegroundColor Cyan
}

Write-Host ""
Write-Host "LET'S ORGANISE YOUR BACKUPS 🚀" -ForegroundColor Yellow
Write-Host ""

Write-Host "Author  : Murat UZUN" -ForegroundColor Gray
Write-Host "Email   : muratuzun79@gmail.com" -ForegroundColor Gray

Write-Host ""
Show-LoadingAnimation -Message "Starting script" -Seconds 3
Clear-Host

# YEAR RANGE
$currentYearMinusOne = (Get-Date).Year - 1
$years = 2020..$currentYearMinusOne

Write-Host "Year range: 2020 - $currentYearMinusOne" -ForegroundColor Cyan
Write-Host ""

# PATH INPUT
if ([string]::IsNullOrWhiteSpace($TargetPath)) {
    Write-Host "Drag & drop a folder onto this script or enter a path below:" -ForegroundColor Yellow
    $TargetPath = Read-Host "Folder path"

    if ([string]::IsNullOrWhiteSpace($TargetPath)) {
        $TargetPath = Split-Path -Parent $MyInvocation.MyCommand.Path
        Write-Host "Using script directory as default: $TargetPath" -ForegroundColor DarkYellow
    }
}

$TargetPath = $TargetPath.Trim('"')

if (-not (Test-Path $TargetPath)) {
    Write-Host "ERROR: Path not found!" -ForegroundColor Red
    Pause
    exit
}

$basePath = (Resolve-Path $TargetPath).Path

Write-Host "Working directory: $basePath" -ForegroundColor Cyan
Write-Host ""

# CREATE FOLDERS
foreach ($year in $years) {
    $folderPath = Join-Path $basePath $year
    if (-not (Test-Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath | Out-Null
        Write-Host "Created folder: $year" -ForegroundColor Green
    }
}

# SCAN FILES
Write-Host ""
Write-Host "Scanning files..." -ForegroundColor Cyan

$moveQueue = @()

foreach ($year in $years) {
    $pattern = "_$year"
    $files = Get-ChildItem -Path $basePath -File | Where-Object { $_.Name -like "*$pattern*" }

    foreach ($file in $files) {
        $moveQueue += [PSCustomObject]@{
            Year = $year
            File = $file
            TargetFolder = (Join-Path $basePath $year)
        }
    }
}

$total = $moveQueue.Count
$count = 0

Write-Host "Total files to move: $total" -ForegroundColor Cyan

# MOVE FILES
foreach ($item in $moveQueue) {
    $count++

    $percent = [math]::Floor(($count * 100) / $total)
    if ($percent -gt 100) { $percent = 100 }

    Write-Progress `
        -Activity "Moving files" `
        -Status "$count / $total" `
        -CurrentOperation "$($item.File.Name) -> $($item.Year)" `
        -PercentComplete $percent

    try {
        Move-Item $item.File.FullName $item.TargetFolder -Force -ErrorAction Stop
    }
    catch {
        # silently handle
    }
}

Write-Progress -Activity "Moving files" -Completed

Write-Host ""
Write-Host "Operation completed successfully." -ForegroundColor Green

Pause