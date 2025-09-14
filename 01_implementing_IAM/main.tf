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
# File: main.tf
# Description: This Terraform configuration creates the core infrastructure:
#   - Resource group to hold IAM and storage resources
#   - Storage account for raw and curated data
#   - Storage containers within the storage account
# =============================================================================


# Resource group for all IAM and storage resources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.common_tags
}

# Storage account used for raw and curated data
# Standard tier, locally redundant, TLS enforced
# Note: public blob access is enabled (not suitable for production)
resource "azurerm_storage_account" "storage" {
  name                             = var.storage_account_name
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  account_tier                     = "Standard"
  account_replication_type         = "LRS"
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = true
  tags                             = local.common_tags
}

# Storage containers within the storage account
# Created from a list of container names (e.g., "raw", "serve")
# Access level: blob-level (anonymous read access to blobs)
resource "azurerm_storage_container" "containers" {
  for_each              = toset(var.container_names)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}
