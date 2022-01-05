param namePrefix string
@minLength(1)
param publisherEmail string
@minLength(1)
param publisherName string
@allowed([
  'Basic'
  'Consumption'
  'Developer'
  'Standard'
  'Premium'
])
param sku string = 'Developer'
param skuCount int = 1
param location string = resourceGroup().location
param subnetResourceId string

var uniqueApimName = '${namePrefix}${uniqueString(resourceGroup().id)}apim'

resource apiManagement 'Microsoft.ApiManagement/service@2020-12-01' = {
  name: uniqueApimName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
    virtualNetworkType: 'External'
    virtualNetworkConfiguration: {
      subnetResourceId: subnetResourceId
    }

  }
  identity: {
    type: 'SystemAssigned'
  }
}