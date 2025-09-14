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
# File: providers.tf
# Description: This Terraform configuration sets up the required providers and
#   their versions for the project. It ensures the Azure Resource Manager
#   (azurerm) and Azure Active Directory (azuread) providers are available
#   and properly configured to interact with Azure resources.
# =============================================================================


# Specify required Terraform version and provider versions
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    # Azure Resource Manager provider for managing Azure resources
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    
    # Azure Active Directory provider for managing AAD resources like groups and users
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.47"
    }
  }
}

# Configure the azurerm provider
provider "azurerm" {
  features {}
}

# Configure the azuread provider
# This provider will authenticate using the same credentials as azurerm
# (e.g., Azure CLI login, Managed Identity, or environment variables)
provider "azuread" {}
