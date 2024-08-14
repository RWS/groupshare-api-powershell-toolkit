# Define the server URL, username, and password for authentication
$server = "https://{your_groupshare_server}.com/" # Change this with your actual Groupshare server
$userName = "{your_username}" # Change this with your actual username
$password = "{your_password}" # Change this with your actual password

# Clear the console to start with a clean output screen
Clear-Host

# Display script title and purpose with decorative separators
Write-Host "======================================" -ForegroundColor Yellow
Write-Host "    PowerShell Toolkit Demonstration   " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Yellow

# Inform the user that the script is starting
Write-Host "`nStarting script to automate small workflows using PowerShell Toolkit..."

# Load necessary PowerShell modules for interacting with the GroupShare server
Write-Host "`nLoading required modules into the PowerShell session..." -ForegroundColor Cyan
Import-Module -Name AuthenticationHelper -ArgumentList $server
Import-Module -Name BackgroundTaskHelper -ArgumentList $server
Import-Module -Name ProjectServerHelper -ArgumentList $server
Import-Module -Name ResourcesHelper -ArgumentList $server
Import-Module -Name SystemConfigurationHelper -ArgumentList $server
Import-Module -Name UserManagerHelper -ArgumentList $server

# Confirm that the modules were loaded successfully
Write-Host "Modules loaded successfully." -ForegroundColor Green

# Retrieve the authentication token using provided credentials
Write-Host "`nRetrieving authentication token..." -ForegroundColor Cyan
$token = SignIn -userName $userName -password $password

# Confirm that the authentication was successful
Write-Host "Authentication successful." -ForegroundColor Green

# List the first 10 containers available on the server
Write-Host "`nListing the first 10 containers:" -ForegroundColor Cyan
$containers = Get-AllContainers -authorizationToken $token

# Iterate through the containers and display their names (up to 10)
for ($i = 0; $i -lt $containers.Count -and $i -lt 10; $i++) {
    Write-Host "[$($i + 1)] $($containers[$i].DisplayName)" -ForegroundColor Green
}

# List the first 10 organizations available on the server
Write-Host "`nListing the first 10 organizations:" -ForegroundColor Cyan
$organizations = Get-AllOrganizations -authorizationToken $token

# Iterate through the organizations and display their names (up to 10)
for ($i = 0; $i -lt $organizations.Count -and $i -lt 10; $i++) {
    Write-Host "[$($i + 1)] $($organizations[$i].Name)" -ForegroundColor Green
}

# Create a new container within the root organization
Write-Host "`nCreating a new container..." -ForegroundColor Cyan
$rootOrganization = $organizations[0]  # Get the first organization as the root
$dbServers = Get-AllDbServers -authorizationToken $token  # Retrieve available database servers
$containerName = "Api Container"  # Set the desired name for the new container

# Create the new container using the provided details
$workingContainer = New-Container -authorizationToken $token -containerName $containerName -organization $rootOrganization -dbServer $dbServers[0] -containerDbName "APIDB"

# Check if the container was created; if not, retrieve the existing one
if ($null -eq $workingContainer) {
    Write-Host "Container already exists. Retrieving the existing container..." -ForegroundColor Yellow
    $workingContainer = Get-Container -authorizationToken $token -containerName $containerName
} else {
    Write-Host "New container created successfully: $($workingContainer.DisplayName)" -ForegroundColor Green
}

# List the first 10 users in the system
Write-Host "`nListing the first 10 users:" -ForegroundColor Cyan
$users = Get-AllUsers -authorizationToken $token

# Iterate through the users and display their display names (up to 10)
for ($i = 0; $i -lt $users.Count -and $i -lt 10; $i++) {
    Write-Host "[$($i + 1)] $($users[$i].DisplayName)" -ForegroundColor Green
}

# Create a new user within the system
Write-Host "`nCreating a new user..." -ForegroundColor Cyan
$userName = "powershell.user@pwsh.com"  # Set the new user's username
$password = "PowershellUser12!!"  # Set the new user's password
$roles = Get-AllRoles -authorizationToken $token  # Retrieve all available roles
$userType = "SDLUser"  # Define the user type
$displayName = "Powershell User"  # Set the display name for the new user

# Attempt to create the new user
$newUser = New-User -authorizationToken $token -userName $userName -password $password -role $roles[0] -organization $rootOrganization -userType $userType -displayName $displayName

# Check if the user was created; if not, retrieve the existing user
if ($null -eq $newUser) {
    Write-Host "User already exists. Retrieving the existing user..." -ForegroundColor Yellow
    $user = Get-User -authorizationToken $token -userName $userName
    Write-Host "User [$($user.DisplayName)] retrieved..." -ForegroundColor Yellow
} else {
    Write-Host "New user created: $($newUser.DisplayName)" -ForegroundColor Green
}

# List the first 10 Translation Memories (TMs) in the system
Write-Host "`nListing the first 10 Translation Memories:" -ForegroundColor Cyan
$tms = Get-AllTMs -authorizationToken $token

# Iterate through the TMs and display their names (up to 10)
for ($i = 0; $i -lt $tms.Count -and $i -lt 10; $i++) {
    Write-Host "[$($i + 1)] $($tms[$i].Name)" -ForegroundColor Green
}

# Create a new Translation Memory in the system
Write-Host "`nCreating a new Translation Memory..." -ForegroundColor Cyan
$tmName = "Powershell Server-based TM"  # Set the name for the new TM
$languageDirections = Get-LanguageDirections -source "en-us" -target @("de-DE", "fr-FR")  # Define language pairs
$workingTM = New-TM -authorizationToken $token -tmName $tmName -container $workingContainer -organization $rootOrganization -languageDirections $languageDirections

# Confirm the creation of the new TM
Write-Host "Translation Memory created: $($workingTM.Name)" -ForegroundColor Green

# Create a new Project Template using the newly created TM
Write-Host "`nCreating a new Project Template with the Translation Memory..." -ForegroundColor Cyan
$templateName = "Powershell Project Template"  # Set the name for the new template
$projectTemplate = New-ProjectTemplate -authorizationToken $token -templateName $templateName -organization $rootOrganization -sourceLanguageCode "en-US" -targetLanguageCodes @("de-DE", "fr-FR") -translationMemories @($workingTM)

# Check if the project template was created; if not, retrieve the existing one
if ($null -eq $projectTemplate) {
    $projectTemplate = Get-ProjectTemplate -authorizationToken $token -templateName $templateName
    Write-Host "Existing Project Template retrieved: $($projectTemplate.Name)" -ForegroundColor Yellow
} else {
    Write-Host "New Project Template created: $($projectTemplate.Name)" -ForegroundColor Green
}

# Create a sample text file to be used in the project creation
Write-Host "`nCreating a sample file for project creation..." -ForegroundColor Cyan
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path  # Get the directory where the script is located
$fileName = "sample.txt"  # Set the name of the sample file
$filePath = Join-Path -Path $scriptDirectory -ChildPath $fileName  # Create the full path for the file
$null = New-Item -Path $filePath -ItemType File -Force  # Create the new text file at the specified location
Add-Content -Path $filePath -Value "This is a sample text."  # Add content to the sample file

# Confirm that the sample file was created
Write-Host "Sample file created at: $filePath" -ForegroundColor Green

# Schedule the creation of a new project using the sample file
Write-Host "`nScheduling a new project creation with the sample file..." -ForegroundColor Cyan
$null = New-Project -authorizationToken $token -projectName "Sample Powershell Project" -organization $rootOrganization -projectTemplate $projectTemplate -filesPath "$scriptDirectory/sample.txt"

# Confirm that the project creation has been scheduled
Write-Host "Project creation has been scheduled. The project will be uploaded in a few moments." -ForegroundColor Green

# Clean up by removing all loaded modules from the current PowerShell session
Write-Host "`nCleaning up and removing modules from the PowerShell session..." -ForegroundColor Cyan
Remove-Module -Name AuthenticationHelper
Remove-Module -Name BackgroundTaskHelper
Remove-Module -Name ProjectServerHelper
Remove-Module -Name ResourcesHelper
Remove-Module -Name SystemConfigurationHelper
Remove-Module -Name UserManagerHelper

# Confirm that all modules were removed successfully
Write-Host "Modules removed successfully." -ForegroundColor Green

# Display script completion message with decorative separators
Write-Host "`n======================================" -ForegroundColor Yellow
Write-Host "            Script Completed            " -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Yellow