<#
.SYNOPSIS
This script processes site information from a CSV file, sets SharePoint Online sites to read-only, and checks their lock state.

.DESCRIPTION
The script ensures the Microsoft.Online.Sharepoint.PowerShell module is installed and imported. It reads a list of SharePoint sites from a CSV file, connects to a SharePoint Online tenant, sets the specified sites to read-only, and checks the lock state for each site, providing feedback on the operation.

.NOTES
The script requires an account with SharePoint Online Administrator permissions for authentication and access to SharePoint sites.

.AUTHOR
SubjectData

.EXAMPLE
.\SharePointLockScript.ps1
This will run the script in the current directory, processing the 'SharePointSites.csv' file and setting the specified SharePoint sites to read-only while checking their lock states.
#>

# Define the module name for SharePoint Online
$moduleName = "Microsoft.Online.Sharepoint.PowerShell"

# Check if the SharePoint Online module is already installed
if (-not(Get-Module -Name $moduleName)) {
    # Install the SharePoint Online module if it's not installed
    Install-Module -Name $moduleName -Force
}

# Import the SharePoint Online module
Import-Module Microsoft.Online.Sharepoint.PowerShell -Force

# Connect to the SharePoint Online service using the provided admin URL
Connect-SPOService -url "https://m365x84490777-admin.sharepoint.com"

# Get the directory of the current script
$myDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the location of the CSV file containing SharePoint site URLs
$CSVLocation = "$myDir\SharePointSites.csv"

try {
    # Import the list of SharePoint site URLs from the CSV file
    $SharePointSites = Import-Csv $CSVLocation
} catch {
    # Handle the error if the CSV file is not found
    Write-Host "No CSV file to read" -BackgroundColor Black -ForegroundColor Red
    exit
}

# Loop through each site in the imported CSV
foreach ($Site in $SharePointSites) {
    try {
        # Check if the URL field is not empty
        if ($Site.Url.ToString() -ne "") {
            # Set the SharePoint site to read-only
            Set-SPOSite -Identity $Site.Url -LockState ReadOnly

            # Check the lock state of the SharePoint site
            $Result = Get-SPOSite -Identity $Site.Url | Select-Object -ExpandProperty LockState
            if ($Result -eq "Unlock") {
                Write-Host $Site.Url " site is" $Result -BackgroundColor Black -ForegroundColor Green
            } else {
                Write-Host $Site.Url " site is" $Result -BackgroundColor Black -ForegroundColor Yellow
            }
        }
    } catch {
        # Handle any exceptions that occur during processing
        Write-Host "Exception occurred for site:" $Site.Url -BackgroundColor Black -ForegroundColor Red
        Continue
    }
}
