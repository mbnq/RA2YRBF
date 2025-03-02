<#
	 ____             _         ______                 
	 |  _ \           | |       |  ____|                
	 | |_) |_ __ _   _| |_ ___  | |__ ___  _ __ ___ ___ 
	 |  _ <| '__| | | | __/ _ \ |  __/ _ \| '__/ __/ _ \
	 | |_) | |  | |_| | ||  __/ | | | (_) | | | (_|  __/
	 |____/|_|   \__,_|\__\___| |_|  \___/|_|  \___\___|
														
	 mbnq00@gmail.com
	 https://www.mbnq.pl/


	 .ini 	Version: 0.8.4525
	  mod	Version: 0.8.4525

	 This script will download latest push from GitHub repo.
	 Simplified version for batch script usage.
	_____________________________________________________________________________________
#>

$repo = "mbnq/RA2YRBF"
$textRepo = "GitHub/"+$repo

Write-Host "-- This script will download latest release from: $textRepo" -ForegroundColor Green

$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases"

if ($releaseInfo -eq $null -or $releaseInfo.Count -eq 0) {
    Write-Host "-- Failed to get release info from $textRepo!" -ForegroundColor Green
    exit 1
}

$latestUploadDate = [datetime]::MinValue
$downloadUrl = $null

foreach ($release in $releaseInfo) {
    foreach ($asset in $release.assets) {
        if ($asset.name -like "*.zip" -and [datetime]$asset.updated_at -gt $latestUploadDate) {
            $latestUploadDate = [datetime]$asset.updated_at
            $downloadUrl = $asset.browser_download_url
        }
    }
}

if ($downloadUrl -eq $null) {
    Write-Host "-- Failed to find the latest release in $textRepo!" -ForegroundColor Red
    exit 1
}

Write-Host "-- Downloading latest from $textRepo..." -ForegroundColor Green
Write-Host "-- Download URL: $downloadUrl" -ForegroundColor Green
$outputFile = "ra2yrbf_latest.zip"

try {
    Start-BitsTransfer -Source $downloadUrl -Destination $outputFile -DisplayName "Downloading the latest mod version from GitHub. Please wait..." -Description "Progress:"
} catch {
    Write-Host "-- Error during download: $_.Exception.Message" -ForegroundColor Red
    Write-Host "-- Stack Trace: $_.Exception.StackTrace" -ForegroundColor Red
    exit 1
}

if (-Not (Test-Path $outputFile)) {
    Write-Host "-- Failed to download the latest release from $textRepo!"-ForegroundColor Red
    exit 1
}

Write-Host "-- Download complete!" -ForegroundColor Green

exit 0
