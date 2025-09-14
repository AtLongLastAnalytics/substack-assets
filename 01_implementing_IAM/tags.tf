# =============================================================================
# Copyright (c) AtLongLast Analytics LLC
#
# Licensed under the MIT License. You may obtain a copy of the License at
# https://opensource.org/licenses/MIT
#
# Repository: https://github.com/AtLongLastAnalytics/substack-companion-code 
# Project: Implementing IAM as a Data Engineer: A Practical Example
# Author: Robert Long
# Date: 2025-09
# Version: 1.0.0
#
# File: tags.tf
# Description: This Terraform configuration defines a local map of common tags
#   that can be applied to all Azure resources. Using a centralized local
#   variable ensures consistency across resources and simplifies maintenance.
# =============================================================================


# Define a local map of common tags to be applied to all Azure resources.
# This ensures consistent tagging across the project and simplifies updates.
locals {
  common_tags = {
    Owner               = "AtLongLast Analytics"
    CostCenter          = "education"
    Environment         = "dev"
    ProjectName         = "iamtutorial"
    DataClassification  = "public"
    AutomationShutdown  = "False"
  }
}
