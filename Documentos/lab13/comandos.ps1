# Provide the name of the closest Azure region in which you can provision Azure VMs
$location = Read-Host -Prompt 'Enter the name of Azure region (i.e. centralus)'
# This is a random string used to assign the name to the Azure storage account
$suffix = Get-Random
$resourceGroupName = 'az400m13l01-RG'
$storageAccountName = 'az400m13blob' + $suffix

# The name of the Blob container to be created
$containerName = 'linktempblobcntr' 

# A completed linked template used in this lab
$linkedTemplateURL = "https://raw.githubusercontent.com/Microsoft/PartsUnlimited/master/Labfiles/AZ-400T05_Implementing_Application_Infrastructure/M01/storage.json" 

# A file name used for downloading and uploading the linked template
$fileName = 'storage.json' 

# Download the lab linked template into in your Azure Cloud Shell home directory
Invoke-WebRequest -Uri $linkedTemplateURL -OutFile "$home/$fileName" 

# Create a resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location 

# Create a storage account
$storageAccount = New-AzStorageAccount `
  -ResourceGroupName $resourceGroupName `
  -Name $storageAccountName `
  -Location $location `
  -SkuName 'Standard_LRS'

$context = $storageAccount.Context

# Create a container
New-AzureStorageContainer -Name $containerName -Context $context
    
# Upload the linked template
Set-AzureStorageBlobContent `
  -Container $containerName `
  -File "$home/$fileName" `
  -Blob $fileName `
  -Context $context

# Generate a SAS token. We set an expiry time of 24 hours, but you could have shorter values for increased security.
$templateURI = New-AzureStorageBlobSASToken `
  -Context $context `
  -Container $containerName `
  -Blob $fileName `
  -Permission r `
  -ExpiryTime (Get-Date).AddHours(24.0) `
  -FullUri

"Resource Group Name: $resourceGroupName"
"Linked template URI with SAS token: $templateURI"