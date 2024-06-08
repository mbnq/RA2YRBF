<#
	 ____             _         ______                 
	 |  _ \           | |       |  ____|                
	 | |_) |_ __ _   _| |_ ___  | |__ ___  _ __ ___ ___ 
	 |  _ <| '__| | | | __/ _ \ |  __/ _ \| '__/ __/ _ \
	 | |_) | |  | |_| | ||  __/ | | | (_) | | | (_|  __/
	 |____/|_|   \__,_|\__\___| |_|  \___/|_|  \___\___|
														
	 mbnq00@gmail.com
	 https://www.mbnq.pl/


	 .ini 	Version: 0.8.4507
	  mod	Version: 0.8.4507

	 This script will download latest push from GitHub repo.
	 Simplified version for batch script usage.
	_____________________________________________________________________________________
#>

$repo = "mbnq/RA2YRBF"
$textRepo = "GitHub/"+$repo

Write-Host "-- This script will download latest release from: $textRepo"

$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases"

if ($releaseInfo -eq $null -or $releaseInfo.Count -eq 0) {
    Write-Host "-- Failed to get release info from $textRepo!"
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
    Write-Host "-- Failed to find the latest release in $textRepo!"
    exit 1
}

Write-Host "-- Downloading latest from $textRepo..."
$outputFile = "ra2yrbf_latest.zip"
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile

if (-Not (Test-Path $outputFile)) {
    Write-Host "-- Failed to download the latest release from $textRepo!"
    exit 1
}

Write-Host "-- Download complete!"

exit 0