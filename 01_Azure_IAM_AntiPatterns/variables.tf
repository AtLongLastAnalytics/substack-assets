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
# File: variables.tf
# Description: This Terraform configuration defines input variables for the module.
#   Variables allow customization of resource names, locations, and configuration
#   without modifying the core Terraform code, making the module reusable.
# =============================================================================


# Azure region to deploy the resources
variable "location" {
  description = "Azure region to deploy the resources."
  type        = string
  default     = "westus2"
}

# Name of the Azure Resource Group
variable "resource_group_name" {
  description = "Name of the Azure Resource Group."
  type        = string
  default     = "rg-iamexample-dev-usw2-001"
}

# Name of the Azure Storage Account
variable "storage_account_name" {
  description = "Name of the Azure Storage Account."
  type        = string
  default     = "stiamexample001"
}

# List of container names to create within the storage account
variable "container_names" {
  description = "List of container names to create."
  type        = list(string)
  default     = ["raw", "serve"]
}
