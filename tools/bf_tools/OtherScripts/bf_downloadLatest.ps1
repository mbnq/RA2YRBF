<#
	 ____             _         ______                 
	 |  _ \           | |       |  ____|                
	 | |_) |_ __ _   _| |_ ___  | |__ ___  _ __ ___ ___ 
	 |  _ <| '__| | | | __/ _ \ |  __/ _ \| '__/ __/ _ \
	 | |_) | |  | |_| | ||  __/ | | | (_) | | | (_|  __/
	 |____/|_|   \__,_|\__\___| |_|  \___/|_|  \___\___|
														
	 mbnq00@gmail.com
	 https://www.mbnq.pl/


	 .ini 	Version: 0.8.4505
	  mod	Version: 0.8.4505

	 This script will download latest push from GitHub repo.
	_____________________________________________________________________________________
#>

function BFDisplayHeader {
	$host.UI.RawUI.WindowTitle = "Brute Force GH Downloader"
	cls
    Write-Host " ____             _         ______                 "
    Write-Host " |  _ \           | |       |  ____|                "
    Write-Host " | |_) |_ __ _   _| |_ ___  | |__ ___  _ __ ___ ___ "
    Write-Host " |  _ <| '__| | | | __/ _ \ |  __/ _ \| '__/ __/ _ \ "
    Write-Host " | |_) | |  | |_| | ||  __/ | | | (_) | | | (_|  __/ "
    Write-Host " |____/|_|   \__,_|\__\___| |_|  \___/|_|  \___\___| "
    Write-Host "                                                    "
    Write-Host " mbnq00@gmail.com                                   "
    Write-Host " https://www.mbnq.pl/                               "
	Write-Host ""
}

$repo = "mbnq/RA2YRBF"
$textRepo = "GitHub/"+$repo

BFDisplayHeader
Write-Host "This script will download latest .zip release from: $textRepo"

$response = Read-Host "- Do you want to proceed? (y/n) then Enter"
if (!($response -eq 'y' -or $response -eq 'Y')) {
	exit 1
}

$releaseInfo = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases"

if ($releaseInfo -eq $null -or $releaseInfo.Count -eq 0) {
	BFDisplayHeader
    Write-Host "- Failed to get release info from $textRepo!"
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
	BFDisplayHeader
    Write-Host "- Failed to find the latest release in $textRepo!"
    exit 1
}

BFDisplayHeader
Write-Host "- Downloading latest from $textRepo..."
$outputFile = "ra2yrbf_latest.zip"
Invoke-WebRequest -Uri $downloadUrl -OutFile $outputFile

if (-Not (Test-Path $outputFile)) {
	BFDisplayHeader
    Write-Host "- Failed to download the latest release from $textRepo!"
    exit 1
}

BFDisplayHeader
Write-Host "- Download complete!"

$response = Read-Host "- Do you want to open $outputFile file? (y/n) then Enter"
if ($response -eq 'y' -or $response -eq 'Y') {
    Start-Process $outputFile
} else {
	Write-Host "- Press any key to exit..."
	[void][System.Console]::ReadKey($true)
}

exit 0

