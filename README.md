# Trados GroupShare API Powershell Toolkit
## Introduction
The Trados GroupShare API Powershell Toolkit allows users to script the Rest API that is available for Trados GroupShare. The purpose of the toolkit is to automate various operations by using the powershell console.

## Table of contents
<details>
  <summary>Expand</summary>

  - [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Configuring the Scripts](#configuring-the-scripts)
  - [Running the Sample_Roundtrip Script](#running-the-sample_roundtrip-script)
  - [Importing and Using PowerShell Modules](#importing-and-using-powershell-modules)
  - [Accessing Module Documentation](#accessing-and-manipulating-resources)
  - [Accessing and manipulating resources](#accessing-and-manipulating-resources)
  - [Understanding the psobject parameters](#understanding-the-psobject-paramters)
  - [Ensuring File Permissions for Toolkit Files](#ensuring-file-permissions-for-toolkit-files)
  - [Function documentation](#function-documentation)
  - [Contribution](#contribution)
  - [Issues](#issues)
  - [Changes](#changes)
</details>

## Getting Started
To run the scripts, ensure you have the following:
1. PowerShell Version 7.4 or Higher
    - If you need to install PowerShell 7.4, follow the instructions provided [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#install-powershell-using-winget-recommended).
2. A GroupShare Server Available
   - Ensure you have access to a GroupShare server, as the scripts will interact with it for various operations.

## Installation
1. Download the Files
    - **Obtain all necessary files:** Ensure you have downloaded the toolkit files, including sample roundtrip script and PowerShell modules. These files should be obtained from the [here](https://github.com/RWS/rws-trados-groupshare-api-powershell-toolkit/). 
    - After downloading, you may need to unblock the zip file. For instructions on how to unblock files, see [Ensuring File Permissions](#ensuring-file-permissions-for-toolkit-files) for Toolkit File.
2. Create Required Folders
    - Create the following folders if they do not already exist:
      -  `C:\users\{your_user_name}\Documents\Powershell`
      -  `C:\users\{your_user_name}\Documents\Powershell\Modules`
3. Copy Sample Roundtrip Script
    - Copy the `Sample_Roundtrip.ps1` scripts into the `Powershell` folder:
    - Ensure these files are placed directly in `C:\Users\{your_user_name}\Documents\Powershell`.
4. Copy PowerShell Modules
    - Copy the PowerShell modules into the `Modules` folder:
      - `...\Powershell\Modules\AuthenticationHelper`
      - `...\Powershell\Modules\BackgroundTaskHelper`
      - `...\Powershell\Modules\ProjectServerHelper`
      - `...\Powershell\Modules\ResourcesHelper`
      - `...\Powershell\Modules\UserManagerHelper`
      - `...\Powershell\Modules\SystemConfigurationHelper`
    - Ensure each module folder contains its respective `.psd1` and `.psm1` files.
5. Verify File Locations
    - Confirm the locations of the files:
      - The roundtrip script should be in `C:\Users\{your_user_name}\Documents\Powershell`.
      - Modules should be in `C:\Users\{your_user_name}\Documents\Powershell\Modules` with appropriate subfolders for each module.

## Configuring the scripts
Before running the scripts, you need to configure the connection to your GroupShare server. This involves setting the server details either in the module files or directly during module import, and configuring the `Sample_Roundtrip.ps1` script with your server and authentication details.

### Configuring PowerShell Modules

#### Option 1: Set the `$server` Parameter in Each Module
1. **Open Each `.psm1` File:** Locate the `.psm1`files in your `Modules` folder.
2. **Edit the `$server` Parameter:** At the top of each `.psm1` file, set the `$server` variable to your GroupShare server URI:
    ```powershell
    $server = "https://your.groupshare.server/uri"
    ```
3. **Save the Changes:** Save each `.psm1` file after updating the `$server` parameter.

#### Option 2: Specify the Server When Importing Modules
1. **Open PowerShell:** Launch PowerShell 7.4 or higher.
2. **Import Modules with `ArgumentList`:** When importing the modules, you can specify the server URI directly using the `-ArgumentList` parameter:
    ```powershell
    Import-Module -Name AuthenticationHelper -ArgumentList "https://your.groupshare.server/uri"
    Import-Module -Name BackgroundTaskHelper -ArgumentList "https://your.groupshare.server/uri"
    Import-Module -Name ProjectServerHelper -ArgumentList "https://your.groupshare.server/uri"
    Import-Module -Name ResourcesHelper -ArgumentList "https://your.groupshare.server/uri"
    Import-Module -Name SystemConfigurationHelper -ArgumentList "https://your.groupshare.server/uri"
    Import-Module -Name UserManagerHelper -ArgumentList "https://your.groupshare.server/uri"
    ```

#### Choosing an Option
- **Option 1:** Use this if you want a persistent server setting in each module. This is helpful if you always use the same server.

- **Option 2:** Use this if you need flexibility to change the server URI dynamically without modifying the module files.

### Configuring the `Sample_Roundtrip.ps1` Script
To use the `Sample_Roundtrip.ps1` script, you need to configure it with your actual server details and authentication credentials. Follow these steps:
1. Open the `Sample_Roundtrip.ps1` Script
    - **Locate the Script:** Find the `Sample_Roundtrip.ps1` file in your `Powershell` folder.
    - **Edit the Script**: Open the file in a text editor of your choice.
2. Update Server and Authentication Details
    - **Set the Server URL:** Update the `$server` variable with the URL of your GroupShare server:
      ```powershell
      $server = "https://your.groupshare.server/uri"
      ```
    - **Set the Username and Password:** Replace the placeholders for `$userName` and `$password` with your actual GroupShare credentials:
      ```powershell
      $userName = "your_username@example.com"
      $password = "your_password" 
      ```
    #### Example configuration
    Replace the following example values with your actual details:
    ```powershell
    # Define the server URL, username, and password for authentication
    $server = "https://your.groupshare.server/uri"
    $userName = "your_username@example.com"
    $password = "your_password"
    ```

3. Verify and Update Module Paths (If Needed)

    Before saving changes, ensure that the PowerShell modules are correctly loaded. Follow these steps to verify module availability and update paths if necessary:
      - **Check Module Availability:** Use the `Get-Module` command to list available modules and verify that each required module is present:
        ```powershell
        Get-Module -ListAvailable -Name AuthenticationHelper, BackgroundTaskHelper, ProjectServerHelper, ResourcesHelper, SystemConfigurationHelper, UserManagerHelper
        ```
      - **Update Module Paths in the Script:** If any modules are not available in the default environment path, update the `Sample_Roundtrip.ps1` script with the full paths to the modules. Locate the section where modules are imported and modify it as follows:
        ```powershell
        Write-Host "`nLoading required modules into the PowerShell session..." -ForegroundColor Cyan
        Import-Module -Name "Path_to_AuthenticationHelper" -ArgumentList $server
        Import-Module -Name "Path_to_BackgroundTaskHelper" -ArgumentList $server
        Import-Module -Name "Path_to_ProjectServerHelper" -ArgumentList $server
        Import-Module -Name "Path_to_ResourcesHelper" -ArgumentList $server
        Import-Module -Name "Path_to_SystemConfigurationHelper" -ArgumentList $server
        Import-Module -Name "Path_to_UserManagerHelper" -ArgumentList $server
        ```
          Replace `"Path_to_Module"` with the actual path where each module is located. For example:
        ```powershell
        Import-Module -Name "C:\Users\your_user_name\Documents\WindowsPowerShell\Modules\AuthenticationHelper" -ArgumentList $server
        ```
4. Save the Changes
    - **Save the File:** After updating the values, save the changes to the `Sample_Roundtrip.ps1` file.

## Running the `Sample_Roundtrip` Script
This section assumes that you have already configured the `Sample_Roundtrip.ps1` script and set up your environment as described in the previous sections. To run the script, follow these steps:
1. Open PowerShell 7.4 or Higher
    - Launch PowerShell 7.4 or a later version.
2. Set the Execution Policy (If Needed)
    -  If you haven’t unblocked the files as described in the [Ensuring File Permissions](#ensuring-file-permissions-for-toolkit-files) for Toolkit Files section, you may need to set the execution policy to Unrestricted to allow script execution. Execute the following command:
        ```powershell
        Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
        ```
    - This command permits PowerShell script execution without requiring local Windows admin privileges and should be executed once per machine and user profile. Note: If you have already unblocked the files, setting the execution policy may not be necessary.
3. Navigate to the Script Location
    - Use the `cd` command to change your directory to the location where the `Sample_Roundtrip.ps1` script is saved:
      ```powershell
      cd C:\Users\{your_user_name}\Documents\Powershell
      ```
4. Run the Script
    - Execute the script using the following command
      ```powershell
      .\Sample_Roundtrip.ps1
      ```

## Importing and Using PowerShell Modules
Before using the functions provided by the modules, you need to ensure they are correctly imported into your PowerShell session. This section outlines the steps to import the modules based on their availability in your environment.

### Importing Modules
1. Check Module Availability
    - Use the `Get-Module` command to verify if the required modules are available in your PowerShell environment:
      ```powershell
      Get-Module -ListAvailable -Name AuthenticationHelper, BackgroundTaskHelper, ProjectServerHelper, ResourcesHelper, SystemConfigurationHelper, UserManagerHelper
      ```
    - If the modules are listed, they are available in the environment path.
2. Import Modules from Environment Path
   -  If the modules are available in the environment path, you can import them directly by name. For example:
      ```powershell
      Import-Module -Name AuthenticationHelper -ArgumentList $server
      Import-Module -Name BackgroundTaskHelper -ArgumentList $server
      Import-Module -Name ProjectServerHelper -ArgumentList $server
      Import-Module -Name ResourcesHelper -ArgumentList $server
      Import-Module -Name SystemConfigurationHelper -ArgumentList $server
      Import-Module -Name UserManagerHelper -ArgumentList $server
      ```
3. Import Modules from Specific Path
    - If the modules are not available in the environment path, you will need to import them from their specific location. Use the full path to the module when importing. For example:
      ```
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\AuthenticationHelper" -ArgumentList $server
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\BackgroundTaskHelper" -ArgumentList $server
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\ProjectServerHelper" -ArgumentList $server
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\ResourcesHelper" -ArgumentList $server
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\SystemConfigurationHelper" -ArgumentList $server
      Import-Module -Name "C:\Users\{your_user_name}\Documents\Powershell\Modules\UserManagerHelper" -ArgumentLis $server
      ```

#### Permanently Add the Module Path to `$env:PSModulePath`
If you want to add the module path permanently so that it remains available across PowerShell sessions and system reboots, follow these steps:
1. Open PowerShell 7 as Administrator
    - Right-click on the PowerShell 7 icon and select *"Run as administrator."*
2. Add the Directory to the Environment Variable
    - Execute the following commands to add your module path to the $env:PSModulePath environment variable:
        ```powershell
        $modulePath = "C:\Users\{Your_username}\Documents\Powershell\Modules"
        [System.Environment]::SetEnvironmentVariable("PSModulePath", "$env:PSModulePath;$modulePath", [System.EnvironmentVariableTarget]::User)
        ```
    - Replace `{Your_username}` with your actual username.
3. Confirm the Path Has Been Added Permanently
    - To verify that the path has been successfully added, run:
        ```powershell
        $env:PSModulePath
        ```
    - You should see your new path included in the output.

### Using the Modules 
Once the modules are imported, you can start using their functions in PowerShell 7. Each module provides specific cmdlets and functions that you can call directly in your session. For example:
  - List available functions in a module:
    ```powershell
    Get-Command -Module AuthenticationHelper
    ```
  - Run a function from a module:
    ```powershell
    SignIn -userName "{your_username}" -password "{your_password}"
    ```
    Replace `SignIn` with any cmdlet or function provided by the module you wish to use. Consult the module's documentation or use `Get-Help` for details on available functions.

## Accessing Module Documentation
The toolkit has been documented with `Get-Help` to provide detailed information on the available cmdlets and functions. Follow these steps to access the documentation:
1. Ensure Modules Are Loaded
    - Before accessing the help documentation, make sure that the necessary modules are imported into your PowerShell 7 session. You can do this by running:
        ```powershell
        Import-Module -Name AuthenticationHelper -ArgumentList $server
        Import-Module -Name BackgroundTaskHelper -ArgumentList $server
        Import-Module -Name ProjectServerHelper -ArgumentList $server
        Import-Module -Name ResourcesHelper -ArgumentList $server
        Import-Module -Name SystemConfigurationHelper -ArgumentList $server
        Import-Module -Name UserManagerHelper -ArgumentList $server
        ```
    If modules are not in the environment path, use the full path for importing as needed.

2. Access Documentation
    - Once the modules are loaded, you can use `Get-Help` to access the documentation for any cmdlet or function provided by the module. For example:
      ```powershell
      Get-Help SignIn
      ```
    - Replace `Get-AuthenticationDetails` with the name of the cmdlet or function you want to learn more about.

3. Explore Additional Help Topics
    - To view a list of available cmdlets and functions in a module, use:
        ```powershell
        Get-Command -Module AuthenticationHelper
        ```
    - For more detailed information on each cmdlet or function, including examples and parameter descriptions, use:
        ```powershell
        Get-Help <Function-Name> -Detailed
        ```
      or  
        ```powershell
        Get-Help <Function-Name> -Examples
        ```

By using `Get-Help`, you can access comprehensive documentation and examples for all the functions available in the toolkit, aiding you in effectively utilizing the provided modules.


## Accessing and Manipulating Resources
Many functions in this toolkit require authorization to access various endpoints. This is facilitated using the `Signin` function from the AuthenticationHelper module, which provides a string authorization token.

## Understanding the `PSObject` Parameters

The toolkit's functions frequently utilize PowerShell objects (`PSObject`) to manipulate or retrieve resources. This design allows for flexibility in managing and interacting with data. Here’s how `PSObject` is used:

- **Function Parameters:** Many functions accept `PSObject` as input parameters. This enables you to use objects generated by the toolkit's functions or create custom PowerShell objects dynamically and pass them as parameters.

- **Data Retrieval and Manipulation:** When retrieving data, functions return `PSObject` instances. These objects can be manipulated or used as input for other functions, providing a seamless way to handle data across different operations.

In the next subsections, you can see the objects information requested by some of the functions and the functions that are returning them.

### Background Task
| Properties required |  Can be retrieved from  |
| - | - |
| Id | Get-AllBackgroundTasks | 

### Project
| Properties required |  Can be retrieved from  |
| - | - |
| ProjectId | Get-AllProjects | 
| Name | Get-Project | 

### Organization
| Properties required |  Can be retrieved from  |
| - | - |
| UniqueId | Get-AllOrganizations |
| Path | Get-Organization |
|  | New-Organization |
|  | Update-Organization |

### Project Template
| Properties required |  Can be retrieved from  |
| - | - |
| Id | Get-AllProjectTemplates |
| Name | Get-ProjectTemplate |
| Description | New-ProjectTemplate |
| OrganizationId | Update-ProjectTemplate |

### Phase
| Properties required |  Can be retrieved from  |
| - | - |
| ProjectPhaseId | Get-ProjectPhases |

### File (From Phases View)
| Properties required |  Can be retrieved from  |
| - | - |
| FileUniqueId | Get-FilesPhasesFromProject | 
| CurrentPhaseId ||
| DueDate ||

### File (From List View)
| Properties required |  Can be retrieved from  |
| - | - |
| UniqueId | Get-ProjectFilesInfo |

### Container
| Properties required |  Can be retrieved from  |
| - | - |
| ContainerId | Get-AllContainers |
| DisplayName | Get-Container |
| | New-Container |
| | Update-Container |

### Translation Memory
| Properties required |  Can be retrieved from  |
| - | - |
| Name | Get-AllTMs |
| TranslationMemoryId | Get-TM |
| ContainerId | Update-TM |
| OwnerId | New-TM |
| FuzzyIndexes | |
| Fields | |
| Copyright | |
| Location | |
| Description | |
| Recognizers | |
| LanguageDirections | |

### LanguageDirection
| Properties required |  Can be retrieved from  |
| - | - |
| Source | Get-LanguageDirections |
| Target | - |

### Field Template
| Properties required |  Can be retrieved from  |
| - | - |
| FieldTemplateId | Get-AllFieldTemplates |
| | Get-FieldTemplate |
| | New-FieldTemplate |
| | Update-FieldTemplate |

### Segment Locking Setting
| Properties required |  Can be retrieved from  |
| - | - |
| UseAndCondition | Get-DefaultSegmentLockingSettings |
| TranslationStatuses | Get-SegmentLockingSettings |
| TranslationOrigins ||
| Score ||
| MTQE ||
| TargetLanguage ||

### Termbase
| Properties required |  Can be retrieved from  |
| - | - |
| Name | Get-Termbase |
| Languages ||

### Field Definition

| Properties required |  Can be retrieved from  |
| - | - |
| Name | Get-FieldDefinition |
| Type ||
| Values ||

### Database Server
| Properties required |  Can be retrieved from  |
| - | - |
| DatabaseServerId | Get-AllDbServers | 
| Name | Get-DbServer | 
| Host | New-DbServer | 
| Description | Update-DbServer | 
| OwnerId || 


### User
| Properties required |  Can be retrieved from  |
| - | - |
| UniqueId | Get-AllUsers |
| Name | Get-AllUsersFromRole |
| Password | Get-User |
| DisplayName | New-User |
| EmailAddress | Update-User |
| PhoneNumber | Add-TranslationProviderToUser |
| OrganizationId | Remove-TranslationProviderFromUser |
| UserType | |

### Role
| Properties required |  Can be retrieved from  |
| - | - |
| UniqueId | Get-AllRoles |
| Permissions | Get-Role |
| Name | New-Role |
| IsProtected | Update-Role |

### Permission
| Properties required |  Can be retrieved from  |
| - | - |
| UniqueId | Get-Permissions |
| FullName | |
| DisplayName | |
| Description | |
| ResourceName | |
| PermissionName | |

### Resource
| Properties required |  Can be retrieved from  |
| - | - |
| Id | Get-AllOrganizationResources |

### Translation Provider
| Properties required |  Can be retrieved from  |
| - | - |
| ProviderSettingId | Get-UserTranslationProvider |

## Function Documentation
In this chapter, you will find all the available functions and their purpose. 
For the functions that requires `psobject` types, you can navigate to the Object structure.

### AuthenticationHelper

| Function Name | Syntax | Description |
| - | - | - |
| SignIn | `[[-userName] <String>] [[-password] <String>]` | This function is generating an authorization key as a string, which can be saved and used for all the other functions that need to access sensitive information from the server <br> **Parameters** <br> **userName** - Mandatory Parameter - Represents the username used for logging on the GroupShare server <br> **password** - Mandatory Parameter - Represents the password used for logging on the GroupShare server | 

### BackgroundTaskHelper

| Function Name | Syntax | Description |
| - | - | - |
| Get-AllBackgroundTasks | `[-authorizationToken] <String> [-startDate] <String> [-endDate] <String> [[-maxLimit] <Int32>] [[-statuses] <Int32[]>] [[-types] <Int32[]>] [[-sortProperty] <String>] [[-sortDirection] <String>]`| Returns all the background tasks. <br> By default, this function returns the first 2000 found items for all statuses and types. In order to add a custom filter for the items optional parameters must be provided <br> **Parameters**  <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **startDate**  and **endDate** - Optional Parameters - Should be in this format `YYYY-MM-DD`<br> When date filter is required, both parameters should be provided <br> **maxLimit** - Optional Parameter - Represents the maximum number of items that should be returned, default is 2000 <br> **statuses** - Optional Parameter - Background Tasks with the specified statuses will be returned; the default parameter includes all statuses. To add status filter this parameter should be an array with one or more of the following values: `1, 2, 4, 8, 16` each of them representing: <br>1 - Queued <br> 2 - InProgress <br> 4 - Canceled <br>8 - Failed <br> 16 - Done <br> **types** - Optional Parameter - Only the Background Tasks with the given types will be returned; the default parameter includes all types. To add this filter, this parameter should be an array with one or more of the following values: `1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18, 20, 22, 23, 24, 25, 26, 27` each of them representing: <br> 1 - ArchiveProject<br>2 - MonitorDueDate<br>3 - DetachProjects<br>4 - DetachProject<br>5 - DeleteProject<br>6 - CleanSyncPackages<br>7 - PublishProject<br>8 - CreateProject<br>9 - ApplyTM<br>10 - BcmImport<br>11 - DeleteTU<br>12 - ImportTM<br>13 - ExportTM<br>14 - RecomputeStats<br>15 - ReindexTM<br>18 - FullAlign<br>20 - AutoReindex<br>22 - UpdateTm<br>23 - GeneratePTAReport<br>24 - DeleteOrganization<br>25 - PackageExport<br>26 - PackageImport<br>27 - EditTU <br> **sortProperty** and **sortDirection** - Optional parameters - Represent the sort method and property for the filter <br> Both parameters are required when sorting is required <br> sortProperty should be one of the following values: <br>`Name`<br>`Status`<br>`CreatedAt`<br>`UpdatedAt`<br>`IsGsTask`<br> sortDirection should be one of the following values: <br>`ASC` <br> `DESC`|
| Remove-BackgroundTasks | `[-authorizationToken] <String> [-backgroundTasks] <PSObject[]>` | Removes the specified background tasks <br> **Parameters** <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **backgroundTasks** - Mandatory Parameter - An Array of [BackgroundTasks](#background-task) objects |

### ProjectHelper

| Function Name | Syntax | Description |
| - | - | - |
| Get-AllProjects | `[-authorizationToken] <String> [[-limit] <Int32>] [[-showAll] <Boolean>] [[-organization] <PSObject>] [[-publishStart] <String>] [[-publishEnd] <String>] [[-dueStart] <String>] [[-dueEnd] <String>] [[-statuses] <String[]>] [[-defaultPublishDates] <Boolean>] [[-defaultDueDates] <Boolean>] [[-sortProperty] <String>] [[-sortDirection] <String>] [<CommonParameters>]` | Returns a list all the projects on the server <br> By default, this function returns the project that have the statuses `Pending`, `Completed` and `In Progress` from the default dates, similarly to the Web UI base filter. **Parameters** <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **limit** - Optional Parameter - By default, it is the maximum integer number <br> **showAll** - Optional Parameter - Boolean Value indicating whether this function should list all projects or the projects from the specified organization <br> **organization** - Optional Parameter - An [organization](#organization) object. If organization filter is required, the **showall** parameter should be false When provided it will display projects from this organization. <br> **publishStart** and **publishEnd** - Optional Parameters - Represents the publish dates of the project. Should be in the format `YYYY-MM-DD` <br> When one or both parameters are provided, the **defaultPublishDates** parameter should be set to false <br> **dueStart** and **dueEnd** - Optional Parameters - Represents the Projects Due date.  Should be in the format `YYYY-MM-DD` <br> When one or both parameters are provided, the **defaultDueDates** parameter should be set to false <br> **statuses** - Optional Parameter - Represents the Statuses of the projects that should be listed <br> Should be one or many of the following values: <br>Pending<br>In Progress<br>Completed<br>Archived<br>Detaches <br> **defaultPublishDates** - Optional Parameter - Boolean indicating whether the publish dates should be the default ones (the default dates from the Web Interface) <br> **defaultDueDates** - Optional Parameter - Boolean indicating whether the due dates should be the default ones (the default dates from the Web Interface) <br> **sortProperty** and **sortDirection** - Optional Parameters - Represent the sorting method for projects. When sorting filter is requried, both parameters should be provided <br> sortProperty should be one of the following values<br>ProjectName<br>PublishAt<br>DueDate<br>Status<br>SourceLanguage<br>OrganizationPath<br>IsSecure<br> sortDirection should be <br>ASC<br>DESC |
| Get-Project | `[-authorizationToken] <String> [[-projectName] <String>] [[-projectId] <String>]` | Returns the project that matches provided parameters<br> When using this function **projectName** and/or **projectId** parameters should be provided. <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**projectName** - Optional Parameter - When this is provided, it returns the project that matches the name. <br> **projectId** - Optional Parameter - When provided is searching the project by the id. <br> If this parameter is provided together with the **projectName**, this method searches the project that match the specified id. If a project is found, it will be returned, otherwise the function will display a not found message on the console and search for the project with the given name |
| New-Project | `[-authorizationToken] <String> [-projectName] <String> [-organization] <PSObject> [-projectTemplate] <PSObject> [-filesPath] <String> [[-description] <String>] [[-dueDate] <String>] [[-restrictFileDownloads] <Boolean>] [[-referenceProjects] <PSObject>]` | Schedule the process of creating a project with the given parameters <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**projectName** - Mandatory Parameter - Represents the name of the project<br>**organization** - Mandatory Parameter - Represents an [organization](#organization) object<br>**projectTemplate** - Mandatory Parameter - Represents the [projectTemplate](#project-template) object used for creating the project<br>**filesPath** - Mandatory Parameter - Represents the physical location of the files on the computer. <br> The file can be a single translatable file, a folder or a zip file. <br> Files in a zip archive are handled according to the folder structure of the archive: Files in an optional "ReferenceFiles" folder are added as reference files. Files in an optional "PerfectMatchFiles" folder are used for perfect match. If a "SourceFiles" folder exists, the files therein are treated as source files. If no "SourceFiles" folder exists, instead all files in the root of the archive are treated as source files (except if in any of the other folders mentioned in this description). If further sub-folders exist in the archive, the files are added to project folders according to their path in "SourceFiles", "ReferenceFiles" or root. To add an sdlxliff file for PerfectMatch for a given source file, the file should be located in the archive at 'PerfectMatchFiles/[target-language-code]/[file path], e.g. 'PerfectMatchFiles/fr-fr/a.docx.sdlliff', or 'PerfectMatchFiles/en-us/folder/a.docx.sdlliff'. To use several PerfectMatch files for a source file, add the files to folders 'PerfectMatchFiles', 'PerfectMatchFiles_1', 'PerfectMatchFiles_2'. <br> **description** - Optional Parameter - Represents the project description <br> **dueDate** - Represents the project due date. Should be in the format `YYYY-MM-DD` or `YYYY-MM-DDThh:mm` <br> **restrictFileDownloads** - Boolean Value indicating whether the files should be allowed for download or not <br> **referenceProjects** - An array of [project](#project) objects for project reference. |
| Remove-Project | `[-authorizationToken] <String> [-projectToRemove] <PSObject>` | Removes the specified project <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br> **projectToRemove** - Mandatory Parameter - The [project](#project) object to remove |
| Get-ProjectPhases | `[-authorizationToken] <String> [-project] <PSObject>` | Returns the project phases for the specified project <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object |
| Get-ProjectSettings | `[-authorizationToken] <String> [-project] <PSObject>` | Returns the settings for the specified project <br>**Parameters** <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object |
| Get-FilesPhasesFromProject | `[-authorizationToken] <String> [-project] <PSObject>` | Returns all the files from the phases view <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object |
| Update-ProjectStatus | `[-authorizationToken] <String> [-project] <PSObject> [-status] <String>` | Changes the project status to completed or started<br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**status** - Mandatory Parameter - Represents the new project status. <br> This value should be `Completed` or `Started` |
| Update-ProjectFilesPhase | `[-authorizationToken] <String> [-project] <PSObject> [-files] <PSObject[]> [-newPhase] <PSObject> [[-comment] <String>]`  | Changes the active phase of the given files object<br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**files** - Mandatory Parameter - An array of [files](#file-from-phases-view) objects that will be updated <br>**newPhase** - The [phase](#phase) object representing the new active phase<br>**comment** - Optional Parameter - The update comment |
| Update-ProjectFilesPlanning | `[-authorizationToken] <String> [-project] <PSObject> [-files] <PSObject[]> [[-updatedAssignees] <PSObject[]>] [[-deliveryAt] <String>] [[-comment] <String>]` | Changes the Assignees and/or the delivery date for the specified files <br>**Parameters****authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**files** - Mandatory Parameter - An array of [files](#file-from-phases-view) objects that will be updated<br>**deliveryAt** - Optional Parameter - Represents the new delivery dates for the files. Should be in the format `YYYY-MM-DD`<br>**comment** - Optional Parameter - The update comment |
| Set-CancelStatusToProjectFiles | `[-authorizationToken] <String> [-project] <PSObject> [-files] <PSObject[]>` | Cancels the specified files <br>**Parameters**<Br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**files** - Mandatory Parameter - An array of [files](#file-from-list-view) objects that will be canceled<br> |
| Get-AnalysisReports | `[-authorizationToken] <String> [-project] <PSObject> [-outputFile] <String> [[-languageCode] <String>]` | Saves the Analysis reports to the given location as a json or xml file <br> **Parameters**<Br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**outputFile** - Mandatory Parameter - Represents the physical location where the file will be saved. <br> The value should end with the `.json` or `.xml` extension<br>**languageCode** - Optional Parameter - Represents the target language code for generating the report. If this parameter is not provided, this function will create the report for all the languages. |
| Get-PtaReport | `[-authorizationToken] <String> [-project] <PSObject> [-languageCode] <String> [-outputLocation] <String>` | Saves the post translation report as a csv file to the specified location **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**languageCode** - Mandatory Parameter - Represents the target language code for the Post Translation Report<br>**outputLocation** - Mandatory Parameter - Represents the physical location where the file will be saved. <br> This value should end with the `.csv` extension |
| Get-AuditTrails | `[-authorizationToken] <String> [-project] <PSObject> [-outputLocation] <String>` | Saves the adit trail report as a csv file to the specified location<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**languageCode** - Mandatory Parameter - Represents the target language code for the Post Translation Report<br>**outputLocation** - Mandatory Parameter - Represents the physical location where the file will be saved. <br> This value should end with the `.csv` extension |
| Export-TemplateUsedForProjectCreation | `[-authorizationToken] <String> [-project] <PSObject> [-outputPath] <String>` | Exports the Project template used for creating the specified project and saves it to the specified location <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object <br> **outputPath** - Mandatory Parameter - Represents the physcal location where the project template will be saved. <br> This value should end with `.sdltpl` extension|
| Import-Package | [-authorizationToken] <String> [-project] <PSObject> [-packagePath] <String> | Imports the package from the specified location to the specified project <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object <br> **packagePath** - Mandatory Parameter - Represents the physical location where the file is stored. <br> The specified file should be a valid `.sdlrpx` file |
| Export-Package | [-authorizationToken] <String> [-project] <PSObject> [-packageDestinationPath] <String> [[-files] <PSObject[]>] | Export the project package for all the files or for the specified files to the given location. <br>  **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object <br>**packageDestinationPath** - Mandatory Parameter - Represents the physical location where the export will be saved. <br> The value should end with `.sdlppx` extension<br> **files** - Optional Parameter - An Array of [file](#file-from-phases-view) objects. If this parameter is provided, the export will target only these files |
| Add-FilesToProject | `[-authorizationToken] <String> [-project] <PSObject> [-filesPath] <String> [[-isReference] <Boolean>]` | Adds translatable or reference files to the specified project <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br> **filesPath** - Mandatory Parameter - Represents the physical location of the file or folder <br> **isReference** - Optional Parameter - Boolean Value indicating whether the files will be added as reference or translatable files. By default this value is false |
| Update-ProjectFiles | `[-authorizationToken] <String> [-project] <PSObject> [-filesPath] <String> [[-isReference] <Boolean>]` | Synchornise the files located at the specified path with the existing files from the given project <br>  **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>  **filesPath** - Mandatory Parameter - Represents the physical location of the file or folder <br> **isReference** - Optional Parameter - Boolean Value indicating whether the files that will be updated are reference or translatable files. By default this value is false |
| Save-AllProjectsFile | `[-authorizationToken] <String> [-project] <PSObject> [-outputLocation] <String> [[-projectfiles] <PSObject[]>] [[-type] <String>] [[-includeTMs] <Boolean>]` | Saves all the files or the specified files or the native target as a zip file to the given location <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**outputLocation** - Mandatory Parameter - Represents the location where the files will be saved. <br> The value should end with `.zip` extension.<br>**projectfiles** - Optional Parameter - An array of [file](#file-from-phases-view) objects <br> **type** - Optional Parameter - Specifies whether to download the latest versions of the files or the target version of the files. <br> The value can be `all` or `targetnativefiles`<br>**includeTMs** - Optional Parameter - Boolean Value indicating whether the Translation Memories should be included or not. <br> If this parameter is true, the **type** parameter must be set to `targetnativefiles` |
| New-PostTranslationReport | `[-authorizationToken] <String> [-project] <PSObject> [[-files] <PSObject[]>]` | Schedule the creation for a new post translation report for all the files or for the specified ones<br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object<br>**files** - Optional Parameter - An array of [file](#file-from-phases-view) objects |
| Get-ProjectFilesInfo | `[-authorizationToken] <String> [-project] <PSObject>` | Returns all of the files from the list view from the specified project<br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**project** - Mandatory Parameter - The [project](#project) object|

### ResourcesHelper

| Function Name | Syntax | Description |
| - | - | - |
| Get-AllTMs | `[-authorizationToken] <String>` | Returns all the Translation Memories form the server <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-TM | `[-authorizationToken] <String> [[-tmName] <String>] [[-tmId] <String>]` | Returns the translation memory that matches the provided parameters <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**tmName** - Optional Parameter <br>**tmId** - Optional Parameter <br> If both **tmName** and **tmId** are provided, this function will search for the translation memory that matches the provided translation memory id. If it not found, an error message will be displayed on the console. Afte that, the function will search for the translation memory with the provided name |
| New-TM | `[-authorizationToken] <String> [-tmName] <String> [-container] <PSObject> [-organization] <PSObject> [-languageDirections] <PSObject[]> [[-fieldTemplate] <PSObject>] [[-description] <String>] [[-copyright] <String>] [[-recognizers] <String>] [[-fuzzyIndexes] <String>]` | Creates a new translation memory with the specified arguments <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **tmName** - Mandatory Parameter - Represents the name of the Translation Memory <br> **container** -Mandatory Parameter - A [container](#container) object<br>**organization** - Mandatory Parameter - An [organization](#organization) object <br> **languageDirections** - Mandatory Parameter - A [languageDirection](#languagedirection) object, representing one or more pairs consiting in one target language and multiple source languages<br> **fieldTemplate** - Optional Parameter - A [fieldTemplate](#field-template) object<br>**description** - Optional Parameter<br>**copyright** - Optional Parameter <br> **recognizers** - Optional Parameters - Recognize settings for the translation memory <br> The value should be a string consisting in comma separated words and one or many of the following values should be provided: <br>`RecognizeNone`<br>`RecognizeDates`<br>`RecognizeTimes`<br>`RecognizeNumbers`<br>`RecognizeAcronyms`<br>`RecognizeVariables`<br>`RecognizeMeasurements`<br>`RecognizeAlphaNumeric`<br>`RecognizeAll`<br> The default value is `RecognizeAll`<br>**fuzzyIndexes** - Optional Parameters - Additionally, multiple fuzzy indexes can be provided<br>The value should be a string consisting in comma separated words and one or many of the following values should be provided: <br>`SourceWordBased`<br>`SourceCharacterBased`<br>`TargetCharacterBased`<br>`TargetWordBased`<br> The default value is `SourceWordBased,TargetWordBased` | 
| Remove-TM | `[-authorizationToken] <String> [-tm] <PSObject>` | Removes the specified Translation Memory <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**tm** - Mandatory Parameter - A [translationMemory](#translation-memory) object, representing an existing Translation Memory|
| Update-TM | `[-authorizationToken] <String> [-tm] <PSObject> [[-languageDirections] <PSObject[]>] [[-fieldTemplate] <PSObject>] [[-tmName] <String>] [[-copyright] <String>] [[-description] <String>]`| Updates an existing Translation Memory with the specified arguments <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**tm** - Mandatory Parameter - A [translationMemory](#translation-memory) object representing an existing Translation Memory<br>**languageDirections** - Optional Parameter - A [languageDirection](#languagedirection) object, representing one or more pairs consiting in one target language and multiple source languages <br> **fieldTemplate** - Optional Parameter -  A [fieldTemplate](#field-template) object <br> **copyright** - Optional Parameter<br> **description** - Optional Parameter |
| Get-AllProjectTemplates | `[-authorizationToken] <String>` | Returns all the existing project templates <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-ProjectTemplate | `[-authorizationToken] <String> [[-templateName] <String>] [[-templateId] <String>]` | Returns the project template that matches the specified arguments <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**templateName** - Optional Parameter <br>**templateId** - OptionalParameter |
| New-ProjectTemplate | `[-authorizationToken] <String> [-templateName] <String> [-organization] <PSObject> [-sourceLanguageCode] <String> [-targetLanguageCodes] <String[]> [-translationMemories] <PSObject[]> [[-segmentLockingSetting] <PSObject[]>] [[-termbases] <PSObject[]>] [[-description] <String>] [[-projectTemplatePath] <String>]` | Creates a new project template with basic or advanced settings <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**templateName** - Mandatory Parameter - Represents the name of the template<br> **organization** - Mandatory Parameter - An [organization](#organization) object <br> **sourceLanguageCode** - Mandatory Parameter - Represents the source language of the project template <br> **targetLanguageCodes** - Mandatory Parameter - An array of language codes, representing the target languages<br> **translationMemories** - Mandatory Parameter - An array of [translationMemory](#translation-memory) objects, representing the translation memories that will be applied for all the target languages<br> **segmentLockingSetting** - Optional Parameter - An array of [segmentLockingSetting](#segment-locking-setting) objects representing advanced settings for the project template. When this parameter is provided, the first element from the array should be the setting for all language pairs<br>**termbases** - Optional Parameter - An array of [termbase](#termbase) objects<br>**description** - Optional Parameter<br>**projectTemplatePath** - Optional Parameter - Additionally, an existing project template can be provided for creating this project template. The value should be an existing path to an actual `sdltpl` file |
| Update-ProjectTemplate | `[-authorizationToken] <string> [-projectTemplate] <psobject> [[-name] <string>] [[-description] <string>] [[-organization] <psobject>] [[-sourceLanguageCode] <string>] [[-targetLanguageCodes] <string[]>] [[-tms] <psobject[]>] [[-segmentLockingSetting] <psobject[]>] [[-termbases] <psobject[]>]`  | Updates an exsting project template <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**projectTemplate** - Mandatory Parameter - A [projectTemplate](#project-template) object, representing an existing project template <br>**name** - Optional Parameter <br>**description** - Optional Parameter<br> **organization** - Optional Parameter - An [organization](#organization) object<br>**sourceLanguageCode** - Optional Parameter - Represents the source language of the project template <br> **targetLanguageCodes** - Optional Parameter - An array of language codes, representing the target languages <br> **tms** - Optional Parameter - An array of [translationMemory](#translation-memory) objects, representing the translation memories that will be applied for all the target languages<br>**segmentLockingSetting** - Optional Parameter - An array of [segmentLockingSetting](#segment-locking-setting) objects representing advanced settings for the project template. When this parameter is provided, the first element from the array should be the setting for all language pairs<br>**termbases** - Optional Parameter - An array of [termbase](#termbase) objects |
| Remove-ProjectTemplate | `[-authorizationToken] <String> [-template] <PSObject>` | Removes an existing project template <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**template** - Mandatory Parameter - A [projectTemplate](#project-template) object, representing an existing project template. | 
| Export-ProjectTemplate | `[-authorizationToken] <String> [-projectTemplates] <PSObject[]> [-outputFilesPath] <String>` | Exports the project template to the specified location <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**projectTemplates** - Mandatory Parameter - An array of [projectTemplate] objects, representing the project template used for export <br> **outputFilesPath** - Mandatory Parameter - Represents the location where the file will be saved. If the **projectTemplates** parameter has only one template object, this value should end with `.sdltpl` extension, otherwise it should end with `.zip`|
| Get-AllTermbases | `[-authorizationToken] <String>` | Gets all the termbases from the server <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources|
| Get-Termbase | `[-authorizationToken] <String> [-termbaseName] <String>` | Return the termbase with the specified name <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**termbaseName** - Mandatory Parameter |
| Import-TMX | `[-authorizationToken] <String> [-tm] <PSObject> [-sourceLanguageCode] <String> [-targetLanguageCode] <String> [-tmxPath] <String>` | Imports the TMX from the given location to the specified Translation Memory with the default settings <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**tm** - Mandatory Parameter - A [translationMemory](#translation-memory) object, representing an existing translation memory<br>**sourceLanguageCode** - Mandatory Parameter - Represents the source language for the scope of the import <br> **targetLanguageCode** - Mandatory Parameter - Represents the target language for the scope of the import <br> **tmxPath** - Mandatory Parameter - Represents the physcal location of the file that will be used for import. Must be a valid tmx file |
| Export-TMX | ` [-authorizationToken] <String> [-tm] <PSObject> [-sourceLanguageCode] <String> [-targetLanguageCode] <String> [-outputFilePath] <String>` | Exports the tmx from an existing Translation Memory to the given location for the specified target and source language <br>**Parameters** <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resource <br> **tm** - Mandatory Parameter - A [translationMemory](#translation-memory) object, representing an existing translation memory<br>**sourceLanguageCode** - Mandatory Parameter - Represents the source language for the scope of the export <br> **targetLanguageCode** - Mandatory Parameter - Represents the target language for the scope of the export <br> **tmxPath** - Mandatory Parameter - Represents the physcal location where the export will be saved<br> The value should end with `.tmx.gz` extension |
| Get-AllFieldTemplates | `[-authorizationToken] <String>` | Gets all the field templates from the server <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-FieldTemplate | `[-authorizationToken] <String> [[-fieldTemplateName] <String>] [[-fieldTemplateId] <String>]` | Get the field template that matches the specified arbuments <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**fieldTemplateName** - Optional Parameter <br> **fieldTemplateId** - Optional Parameter<br>If both **fieldTemplateName** and **fieldTemplateId** are provided, this function will search for the template that matches the specified id. If it is not found, an error message will be displayed on the console. After that, the function will search for the field template with the given name |
| New-FieldTemplate | `[-authorizationToken] <String> [-name] <String> [-organization] <PSObject> [-fields] <PSObject[]> [[-description] <String>]`  | Creates a new field template <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**name** - Mandatory Parameter <br> **organization** - Mandatory Parameter - An [organization](#organization) object<br>**fields** - Mandatory Parameters - An array of [fieldDefinition](#field-definition) objects<br>**description** - Optional Parameter | 
| Remove-FieldTemplate | `[-authorizationToken] <String> [-fieldTemplate] <PSObject>` | Removes an existing field template<br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**fieldTemplate** - Mandatory Parameter - A [fieldTemplate](#field-template) object representing an existing field template | 
| Update-FieldTemplate | `[-authorizationToken] <String> [-fieldTemplate] <PSObject> [[-name] <String>] [[-fields] <PSObject[]>] [[-description] <String>] [[-organization] <PSObject>]`  | Updates an existing field template <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**fieldTemplate** - Mandatory Parameter - A [fieldTemplate](#field-template) object representing an existing field template<br>**name** - Optional Parameter<br> **fields** - Optional Parameter - An array of [fieldDefinition](#field-definition) objects<br>**description** - Optional Parameter<br>**organization** - Optional Parameter - An [organization](#organization) object. |
| Get-LanguageDirections | `[[-source] <String>] [[-target] <String[]>]` | Helper function that organize on target language to many source languages and returns it as an object for creating/updating translation memories <br>**Parameters**<br>**source** - Mandatory Parameter - Represents the source language code<br>**target** - Mandatory Parameter - An array of language codes representing the target languages |
| Get-FieldDefinition | `[-name] <String> [-type] <String> [[-values] <String[]>]` | Helper function to create a field definition that can be used for creating/updating field templates <br> **Parameters**<br>**name** - Mandatory Parameter - Name of the field definition <br> **type** - Mandatory Parameter - Type of the field definition<br> Should be one of the following values: <br>`SingleString`<br>`MultipleString`<br>`Integer`<br>`DateTime`<br>`SinglePicklist`<br>`MultiplePicklist`<br>**values** - Optional Parameter - Optionally, values can be provided for the fields only when the **type** parameter is `SinglePicklist` or `MultiplePicklist` | 
| Get-DefaultSegmentLockingSettings | | Helper function that creates the default segment locking settings for project templates |
| Get-SegmentLockingSettings | `[-targetLanguageCode] <String> [-anyTranslationStatuses] <Boolean> [-translationStatuses] <String[]> [-translationOrigins] <String[]> [[-mtqe] <Enumerable[]>] [[-score] <Nullable>]` | Helper function to create custom segment locking settings for project templates <br> **Parameters** <br> **targetLanguageCode** - Mandatory Parameter - The target language code<br> If the setting is for all language pairs, the value of this parameter should be an empty string<br>**anyTranslationStatuses** - Mandatory Parameter - Boolean value indicating whether this settings will be: <br> ANY of the specified translation statuses OR origins when true <br> BOTH the specified translation statuses AND origins when false <br> **translationStatuses** - Mandatory Parameter - An array of string representing the translation statuses<br> Should be one or more of the following values: <br>`SignedOff`<br>`TranslationApproved`<br>`Translated`<br>`TranslationRejected`<br>`Draft`<br>`SignOffRejected` <br> **translationOrigins** - Mandatory Parmaeter - An array of string representing the translation origins<br> Should be one or more of the following values: <br>`TranslationMemory`<br>`NeuralMachineTranslation`<br>`Interactive`<br>`PerfectMatch`<br>`AutoPropagated`<br>`CopyFromSource`<br>`AutomatedAlignment`<br>`ReverseAlignment`<br>`MachineTranslation`<br>`AdaptiveMachineTranslation` <br> **mtqe** - Optional Parameter - An array of string representing the mtqe<br> This parameter should be provided only when the **targetLanguageCode** is not an empty string and should be one of the following values<br>`Expected values`<br>`Good`<br>`Adequate`<br>`Poor` <br> **score** - Optional Parameter - The score as an integer<br>Should be a positive integer and not exceed 100 |

### SystemConfigurationHelper
| Function Name | Syntax | Description |
| - | - | - |
| Get-Licensing | `[-authorizationToken] <String>` | Gets the GroupShare licensing information <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-AllDbServers | `[-authorizationToken] <String>` | Gets all the databases from the server <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-DBServer | `[-authorizationToken] <String> [[-serverName] <String>] [[-serverId] <String>]` | Gets the database server with the specified arguments <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **serverName** - Optional Parameter <br> **serverId** - Optional Parameter <br> If both **serverName** and **serverId** are provided, the function will search for the server that matches the server id. If it is not found, an error message will be displayed on the console. After that, the function will search for the server that matches the provided name | 
| New-DbServer | ` [-authorizationToken] <String> [-name] <String> [-serverName] <String> [-authentication] <String> [-ownerOrganization] <PSObject> [[-description] <String>] [[-userName] <String>] [[-password] <String>]` | Creates a new database server <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br> **serverName** - Mandatory Parameter <br> **authentication** - Represents the authentication method on the server. This parameter can be `Windows` or `Database`. If this parameter value is `Database` the **userName** and **password** parameter must be provided <br> **ownerOrganization** - Mandatory Parameter - An [organization](#organization) object, representing the owner of this server <br> **description** - Optional Parameter <br> **description** - Optional Parameter <br> **userName** and **password** - Optional Parameters - Represents the credentials for accessing this database. If the **authentication** parameter is `Database` these two parameters must be provided |
| Remove-DbServer | `[-authorizationToken] <String> [-dbServer] <PSObject>` | Removes an existing database server <br> **Parameters** <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br> **dbServer** - Mandatory Parameter - A [dbServer](#database-server) object, representing an existing database server |
| Update-DbServer | `[-authorizationToken] <String> [-dbServer] <PSObject> [[-newServerName] <String>] [[-description] <String>] [[-authentication] <String>] [[-userName] <String>] [[-password] <String>]` | Updates an existing database server <br> **Parameters** <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **dbServer** - Mandatory Parameter - A [dbServer](#database-server) object, representing an existing database server <br> **newServerName** - Optional Parameter <br> **description** - Optional Parameter <br> **authentication** - Optional Parameter - Represents the updated authentication method on the server. This parameter can be `Windows` or `Database`. If this parameter value is `Database` the **userName** and **password** parameter must be provided <br> **userName** and **password** - Optional Parameters - Represents the credentials for accessing this database. If the **authentication** parameter is `Database` these two parameters must be provided | 
| Get-AllContainers | `[[-authorizationToken] <String>]` | Returns all the containers from the server <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-Container | `[-authorizationToken] <String> [[-containerName] <String>] [[-containerId] <String>]` | Returns the container with the specified arguments <br> **Parameters**<br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **containerName** - Optional Parameter <br> **containerId** - Optional Parameter <br> If both **containerName** and **containerId** are provided, this function will search for the container that matches the specified id. If the container is not found, an error message will be displayed on the console. After that the function will search for the container with the provided name |
| New-Container | `[-authorizationToken] <String> [-containerName] <String> [-organization] <PSObject> [-DbServer] <PSObject> [[-containerDbName] <String>]` | Creates a new container <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**containerName** - Mandatory Parameter <br> **organization** - Mandatory Parameter - An [organization](#organization) object representing the owner organization of the container<br>**dbServer** - Mandatory Parameter - A [dbServer](#database-server) object<br>**containerDbName** - Optional Parameter - When provided, this parameter should not container whitespaces and should not start with a number |
| Remove-Container | `[-authorizationToken] <String> [-container] <PSObject>` | Removes an existing container <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**container** - Mandatory Parameter - A [container](#container) object |
| Update-Container | `[-authorizationToken] <String> [-container] <PSObject> [[-containerName] <String>]` | Updates an existing container  <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br> **container** - Mandatory Parameter - A [container](#container) object<br> **containerName** - Optional Parameter |

### UserManagerHelper

| Function Name | Syntax | Description |
| - | - | - |
| Get-AllUsers | `[-authorizationToken] <String> [[-organization] <PSObject>] [[-sortProperty] <String>] [[-sortDirection] <String>] [[-maxLimit] <Int32>]` | Returns all the users from the server or the users within the specified filter <br> **Parameters**<br> See [organization](#organization) object structure <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **organization** - Optional Parameter - An [organization](#organization) object. When this parameter is provided, only the users within this organization will be displayed <br> **sortProperty** and **sortDirection** - Optional Parameters - The sort method and property <br> When sorting is necesarry both parameters should be provided <br> sortProperty should be one of the following values: <br>`DisplayName`<br>`Name`<br>`UserType`<br>`EmailAddress`<br> sortDirection should be one of the following values: <br> `ASC` <br> `DESC`<br> **maxLimit** - OptionalParameter - Represents the maximum number of users to be returned <br> Default is 100|
| Get-AllUsersFromRole | `[-authorizationToken] <String> [-role] <PSObject>` | Gets all the user within the specified role <br> **Parameters**<br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **role** - Mandatory Parameter - A [role](#role) object |
| Get-User | `[-authorizationToken] <String> [[-userName] <String>] [[-userId] <String>]` | Returns the user that matches the specified arguments <Br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**userName** - Optional Parameter - Represents the username user for logging on the server <br>**userId** - Optional Parameter - Represents the unique id of the user <br> If both **userName** and **userId** parameters are provided the function will search for the user that matches the user Id, ignoring the userName |
| New-User | `[-authorizationToken] <String> [-userName] <String> [-password] <String> [-organization] <PSObject> [-userType] <String> [-displayName] <String> [-role] <PSObject> [[-emailAddress] <String>] [[-phoneNumber] <String>] [[-description] <String>]` | Creates a new user <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**userName** - Mandatory Parameter <br>**password** - Mandatory Parameter - Should match the password complexity rules <br> **organization** - Mandatory Parameter - An [organization](#organization) object<br>**userType** - Mandatory Parameter - This parameter should be one of the following values: <br>`SDLUser`<br>`WindowsUser`<br>`CustomUser`<br>`IdpUser` <br> **displayName** - Mandatory Parameter <br>**role** - Mandatory Parameter - A [role](#role) object. Represents the role that this user will have in this organization. <br> **emailAddress** - Optional Parameter <br> **phoneNumber** - Optional Parameter <br> **description** - Optional Parameter |
| Remove-User | `[-authorizationToken] <String> [-user] <PSObject>` | Removes the specified user <br> **Parameters** <br> **authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources <br> **user** - Mandatory Parameter - A [user](#user) object |
| Update-User | `[-authorizationToken] <string> [-user] <psobject> [[-password] <string>] [[-organization] <psobject>] [[-userType] <string>] [[-displayName] <string>] [[-emailAddress] <string>] [[-phoneNumber] <string>] [[-description] <string>]` | Updates an existing user <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**user** - Mandatory Parameter - A [user](#user) object<br>**password** - Optional Parameter - Should match the password complexity rules <br> **organization** - A [organization](#organization) object, representing the new user's organization<br>**userType** - Optional Parameter - This parameter should be one of the following values: <br>`SDLUser`<br>`WindowsUser`<br>`CustomUser`<br>`IdpUser` <br> **displayName** - Optional Parameter <br> **emailAddress** - Optional Parameter <br> **phoneNumber** - Optional Parameter <br> **description** - Optional Parameter  |
| Update-RoleToUser | `[-authorizationToken] <String> [-organization] <PSObject> [-role] <PSObject> [-user] <PSObject> [-updateMode] <String>` | Adds or removes a role to an existing user for the given organization <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**organization** - Mandatory Parameter - An [organization](#organization)<br>**role** - Mandatory Parameter - A [role](#role) object<br>**user** - Mandatory Parameter - A [user](#user) object<br> **updateMode** - Mandatory Parameter - This parameter should be either `Add` or `Remove`|
| Get-AllOrganizations | `[-authorizationToken] <String>` | Returns all the organizations from the server <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-Organization | `[-authorizationToken] <String> [[-organizationName] <String>] [[-organizationId] <String>]` | Returns the specified organization <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**organizationName** - Optional Parameter <br> **organizationId** - Optional Parameter <br> When both **organizationName** and **organizationId** are provided, this function will search for the organization with the specified organization Id. If it is not foud, an error message will be displayed on the console. After that, the function will search for the organization with the specified name |
| New-Organization | `[-authorizationToken] <String> [-parentOrganization] <PSObject> [-organizationName] <String> [[-organizationDescription] <String>] [[-isLibrary] <Boolean>]` | Creates a new organization within the provided <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**parentOrganization** - Mandatory Parameter - An [organization](#organization) object will be the parent of this new organization<br>**organizationName** - Mandatory Parameter<br>**organizationDescription** - Optional Parameter <br> **isLibrary** - Optional Parameter - Boolean Value indicating whether the new organization will be a library or not |
| Remove-Organization | `[-authorizationToken] <String> [-organization] <PSObject>` | Removes the provided organization <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**organization** - Mandatory Parameter - An [organization](#organization) object.|
| Update-Organization | `[-authorizationToken] <String> [-organization] <PSObject> [[-organizationName] <String>] [[-organizationDescription] <String>]` | Updates an existing organization <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**organization** - Mandatory Parameter - An [organization](#organization) object <br> **organizationName** - Optional Parameter - The new organization name<br>**organizationDescription** - Optional Parameter - the new organization description |
| Get-AllRoles | `[-authorizationToken] <String>` | Returns all the roles from the server <br>**Parameters** <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources |
| Get-Role | `[-authorizationToken] <String> [[-roleName] <String>] [[-roleId] <String>]` | Returns the role that matches the provided arguments <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**roleName** - Optional Parameter <br>**roleId** - Optional Parameter <br> If both **roleName** and **roleId** are provided, this function will search for the role with the specified id. If the role is not found, an error message will be displayed on the console. After this, the function will search for the role with the provided name|
| New-Role | `[-authorizationToken] <String> [-roleName] <String> [-permissions] <PSObject[]>` | Creates a new role with the specified permissions <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**roleName** - Mandatory Parameter - The display name of the role <br> **permissions** - An array of [permission](#permission) objects |
| Remove-Role | `[-authorizationToken] <String> [-role] <PSObject>` | Removes an existing role <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**role** - Mandatory Parameter - A [role](#role) object |
| Update-Role | `[-authorizationToken] <String> [-role] <PSObject> [[-newRoleName] <String>] [[-permissions] <PSObject[]>]` | Updates an existing role <br> **Parameters** <br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**role** - A [role](#role) object <br>**newRoleName** - Optional Parameter - The New Display Name for the specified role <br> **permissions** - Optional Parameters - An array of [permission](#permission) object. Represents the new set of permissions. |
| Get-Permissions | `[-authorizationToken] <String> [[-permissionNames] <String[]>]` | Returns all the existing permission on the server or only the ones from with the specified names <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**permissionNames** - Optional Parameters - When the names of the permissions are provided, only the permissinos with the given names will be returned. |
| Get-AllOrganizationResources | `[-authorizationToken] <String> [-organization] <PSObject>` | Returns all the resources within the specified organization <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**organization** - Mandatory Parameter - An [organization](#organization) object |
| Move-OrganizationResources | `[-authorizationToken] <String> [-resources] <PSObject[]> [-newOrganization] <PSObject>` | Moves content resources from one organization to another <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**resources** - Mandatory Parameter - An array of [resource](#resource) objects, representing the resources that will be moved <br> **newOrganization** - Mandatory Parameter - An [organization](#organization) representing the new organization that will contain the resources |
| Join-ResourcesToOrganization | `[-authorizationToken] <String> [-resources] <PSObject[]> [-organization] <PSObject>` | Link the specified resources with the provided organization <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**resources** - Mandatory Parameter - An array of [resource](#resource) objects, representing the resources that will be updated <br> **organization** - Mandatory Parameter - An [organization](#organization) representing the organization that will contain the resources |
| Split-ResourcesFromOrganization | `[-authorizationToken] <String[]> [-resources] <PSObject[]> [-organization] <PSObject>` | Unlink the specified resources with the provided organization <br>**Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**resources** - Mandatory Parameter - An array of [resource](#resource) objects, representing the resources that will be updated <br> **organization** - Mandatory Parameter - An [organization](#organization) representing the organization that will not contain the specified resources anymore |
| Get-UserTranslationProvider | `[-authorizationToken] <String> [-user] <PSObject>` | Return the tranlsation provider from the given user <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**user** - Mandatory Parameter - A [user](#user) object |
| Add-TranslationProviderToUser | `[-authorizationToken] <String> [-user] <PSObject> [-clientId] <String> [-clientSecret]` | Adds a translation provider to the given user <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**user** - Mandatory Parameter - A [user](#user) object<br> **clientId** - Mandatory Parameter <br> **clientSecret**  -Mandatory Parameter |
| Remove-TranslationProviderFromUser | `[-authorizationToken] <string> [-user] <psobject> [-translationProvider] <psobject>` | Removes the specified translation provider form the specified user <br> **Parameters**<br>**authorizationToken** - Mandatory Parameter - Required for accessing sensitive resources<br>**user** - Mandatory Parameter - A [user](#user) object <br> **translationProvider** - Mandatory Parameter - A [translationProvider](#translation-provider) object |

## Ensuring File Permissions for Toolkit Files

Windows may block files downloaded from the internet for security reasons. To ensure the toolkit functions properly, unblock the downloaded zip file.

### Step-by-Step Instructions

#### Locate the Downloaded File:
- Open File Explorer and navigate to the folder containing the downloaded file.

#### Right-Click on the File:
- Right-click on the file to open the context menu.

#### Open File Properties:
- Select "Properties" from the context menu. 

#### Unblock the File:
- In the Properties dialog, go to the "General" tab.
- Look for the message: "This file came from another computer and might be blocked to help protect this computer."
- If this message is present, check the box next to "Unblock."

#### Apply and Close:
- Click "Apply" to save the changes.
- Click "OK" to close the Properties dialog.

## Contribution
If you want to add a new functionality or you spot a bug please fill free to create a pull request with your changes.

## Issues
If you find an issue you report it here.

## Changes
### Version
