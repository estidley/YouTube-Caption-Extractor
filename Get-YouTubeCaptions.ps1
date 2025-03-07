<#
.SYNOPSIS
    This script fetches captions for a YouTube video using the youtube-caption-extractor npm package and extracts the subtitles to a text file.
.DESCRIPTION
    This script uses Node.js and the youtube-caption-extractor npm package to fetch captions for a YouTube video based on the video ID and language.
    It then extracts the subtitles from the JSON output and saves them to a text file on the user's desktop.
    The video ID, language, and output file paths can be customized as needed.
.NOTES
    File Name      : Get-YouTubeCaptions.ps1
    Author         : Ethan Stidley
    Prerequisite   : Node.js, youtube-caption-extractor npm package
#>


function Get-YouTubeCaptions {
    param (
        [string]$videoID,
        [string]$lang = "en",
        [string]$outputFile = "YouTubeCaptions.json"
    )

    # Ensure Node.js is installed
    if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
        Write-Host "Node.js is not installed. Please install Node.js from https://nodejs.org/"
        return
    }

    # Get the global npm package location
    $npmPrefix = npm prefix -g
    $packagePath = "$npmPrefix\node_modules\youtube-caption-extractor/dist/index.js"

    if (-not (Test-Path $packagePath)) {
        Write-Host "youtube-caption-extractor is not installed. Run 'npm install -g youtube-caption-extractor'"
        return
    }

    # Convert Windows path to a file:// URL
    $packageURL = (Resolve-Path $packagePath).Path -replace '\\', '/'
    $packageURL = "file:///$packageURL"

    # Create the JavaScript script dynamically
    $scriptContent = @"
import { getSubtitles, getVideoDetails } from '$packageURL';
import fs from 'fs';

const videoID = '$videoID';
const lang = '$lang';

const run = async () => {
  try {
    const subtitles = await getSubtitles({ videoID, lang });
    const videoDetails = await getVideoDetails({ videoID, lang });

    const output = { subtitles, videoDetails };

    fs.writeFileSync('$outputFile', JSON.stringify(output, null, 2));
    console.log("Captions and video details saved to $outputFile");
  } catch (error) {
    console.error('Error:', error);
  }
};

run();
"@

    # Define the script path
    $scriptPath = "$env:TEMP\YouTubeCaptionExtractor.mjs"

    # Save the script to a file
    Set-Content -Path $scriptPath -Value $scriptContent -Encoding UTF8

    # Run the script using Node.js
    Write-Host "Fetching captions for video ID: $videoID..."
    node $scriptPath
}

function Extract-Subtitles {
    param (
        [string]$jsonFile = "$env:USERPROFILE\Desktop\YouTubeCaptions.json",
        [string]$outputTxt = "$env:USERPROFILE\Desktop\YouTubeSubtitles.txt"
    )

    # Check if JSON file exists
    if (-not (Test-Path $jsonFile)) {
        Write-Host "Error: JSON file not found at $jsonFile"
        return
    }

    # Read and parse JSON
    $jsonContent = Get-Content -Path $jsonFile -Raw | ConvertFrom-Json

    # Extract subtitles (handle missing data gracefully)
    if ($jsonContent.subtitles -and $jsonContent.subtitles.Count -gt 0) {
        $subtitlesText = $jsonContent.subtitles.text -join "`r`n"
        $subtitlesText | Set-Content -Path $outputTxt -Encoding UTF8
        Write-Host "Subtitles extracted and saved to $outputTxt"
    } else {
        Write-Host "Error: No subtitles found in JSON file."
    }
}


# Create file structure
New-Item -Path "$env:USERPROFILE\Desktop" -Name "YouTubeCaptions.json" -ItemType "file" -Force

# Change directory to the desktop
Set-Location "$env:USERPROFILE\Desktop"

# Get YouTube captions for a video
Get-YouTubeCaptions -videoID "dQw4w9WgXcQ" -lang "en" -outputFile "YouTubeCaptions.json"

# Extract subtitles from the JSON file
Extract-Subtitles -jsonFile "$env:USERPROFILE\Desktop\YouTubeCaptions.json" -outputTxt "$env:USERPROFILE\Desktop\YouTubeSubtitles.txt"

# Display the extracted subtitles
Get-Content -Path "$env:USERPROFILE\Desktop\YouTubeSubtitles.txt"
