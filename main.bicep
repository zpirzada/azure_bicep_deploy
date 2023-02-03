@maxLength(15)
param storageAccountPrefix string = 'bicepstore'
param location string = 'West US 3'
//param resourceGroupName string = 'zeb-bicep-gh-rg'
param appWebplan string = 'bicepapplan'
param appWeb string = 'bicepaplaunch'
param storageName string = 'zbstorage2'

var sta = '${storageAccountPrefix}${uniqueString(subscription().id)}'

var applan = '${appWebplan}${uniqueString(subscription().id)}'
var appw = '${appWeb}${uniqueString(subscription().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: sta
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: applan
  location: location
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appw
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}


module storageAcct 'storage.bicep' = {
  name: 'storageModule'
  params: {
    storageLocation: location
    storageName: storageName
  }
}
 