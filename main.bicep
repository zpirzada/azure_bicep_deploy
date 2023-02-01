@maxLength(11)
param storageAccountPrefix string = 'zebstorage'
param location string = resourceGroup().location

param appWebplan string = 'zebappwlaunchplan'
param appWeb string = 'zebappwlaunch'

var sta = '${storageAccountPrefix}${uniqueString(subscription().id)}'

var applan = '${appWebplan}${uniqueString(subscription().id)}'
var appw = '${appWeb}${uniqueString(subscription().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: sta
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
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
