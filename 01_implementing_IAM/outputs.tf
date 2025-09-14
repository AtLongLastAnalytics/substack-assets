# =============================================================================
# Copyright (c) AtLongLast Analytics LLC
#
# Licensed under the MIT License. You may obtain a copy of the License at
# https://opensource.org/licenses/MIT
#
# Repository: https://github.com/AtLongLastAnalytics/substack-companion-code 
# Project: Azure IAM Anti-Patterns: Avoid Putting Your Data at Risk
# Author: Robert Long
# Date: 2025-09
# Version: 1.0.0
#
# File: outputs.tf
# Description: This Terraform configuration defines outputs for key resources
#   created in the infrastructure. These outputs make it easy to reference
#   resource attributes (e.g., names, endpoints, and Azure AD group IDs) from
#   other modules, scripts, or for informational purposes.
# =============================================================================


# Output the name of the resource group
output "resource_group_name" {
  description = "The name of the resource group that contains IAM and storage resources."
  value       = azurerm_resource_group.rg.name
}

# Output the name of the storage account
output "storage_account_name" {
  description = "The name of the Azure Storage Account used for raw and curated data."
  value       = azurerm_storage_account.storage.name
}

# Output the primary Blob endpoint of the storage account
output "storage_account_primary_endpoint" {
  description = "The primary Blob service endpoint URL of the storage account."
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

# Output the list of storage container names created
output "storage_container_names" {
  description = "A list of all storage container names provisioned in the storage account."
  value       = keys(azurerm_storage_container.containers)
}

# Output the Object ID of the Data Engineers Azure AD group
output "data_engineer_group_id" {
  description = "The Object ID of the Data Engineers Azure AD group."
  value       = azuread_group.data_engineers.object_id
}

# Output the Object ID of the Data Analysts Azure AD group
output "data_analyst_group_id" {
  description = "The Object ID of the Data Analysts Azure AD group."
  value       = azuread_group.data_analysts.object_id
}
