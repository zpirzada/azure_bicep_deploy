param storageAccountPrefix string = 'bicepst2'
param storageLocation string = 'West US 3'
param storageName string ='${storageAccountPrefix}${uniqueString(subscription().id)}'

resource storageAcct 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
  location: storageLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
  properties: {}
}