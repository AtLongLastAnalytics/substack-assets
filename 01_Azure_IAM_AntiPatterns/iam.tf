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
# File: iam.tf
# Description: This Terraform configuration defines Azure AD groups for
#   Data Engineers and Data Analysts, and assigns appropriate role
#   permissions on Azure Storage resources.
# =============================================================================


# Azure AD group for Data Engineers
# Members: users who ingest raw data and create curated datasets
resource "azuread_group" "data_engineers" {
  display_name     = "gp-data-engineer"
  security_enabled = true
}

# Role assignment: Data Engineers - Storage Blob Data Contributor
# Scope: entire storage account (read/write access to all containers)
resource "azurerm_role_assignment" "ra_engineers_storage" {
  scope                = azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azuread_group.data_engineers.object_id
}

# Azure AD group for Data Analysts
# Members: users who consume curated data for analysis and reporting
resource "azuread_group" "data_analysts" {
  display_name     = "gp-data-analyst"
  security_enabled = true
}

# Role assignment: Data Analysts → Storage Blob Data Reader
# Scope: only the "serve" storage container (read-only access)
# Note: using .resource_manager_id for container-level scope
resource "azurerm_role_assignment" "ra_analysts_serve_container" {
  scope                = azurerm_storage_container.containers["serve"].resource_manager_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azuread_group.data_analysts.object_id
}
