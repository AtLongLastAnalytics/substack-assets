# Implementing IAM as a Data Engineer: A Practical Example
### Substack article: Implementing IAM as a Data Engineer: A Practical Example

This Terraform project deploys a simple Azure environment for a data engineering use case, including:

- Azure Resource Group
- Azure Storage Account with multiple containers
- Azure Active Directory (AAD) groups for Data Engineers and Data Analysts
- Role assignments for AAD groups on the storage account/containers
- Common tags applied to all resources

The module is designed as a reusable pattern for managing IAM and storage resources in Azure.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Resources Created](#resources-created)
- [Variables](#variables)
- [Outputs](#outputs)
- [Usage](#usage)
- [Best Practices](#best-practices)
- [License](#license)

---

## Prerequisites

Before deploying, ensure you have:

- [Terraform ≥ 1.6.0](https://www.terraform.io/downloads)
- Azure CLI installed and authenticated (`az login`)
- Appropriate permissions to create:
  - Resource Groups
  - Storage Accounts & Containers
  - Azure AD Groups
  - Role assignments

---

## Resources Created

- **Resource Group:** Logical container for all resources
- **Storage Account:** Standard LRS storage account for raw and curated datasets
- **Storage Containers:** Created from a list of container names (default: `raw`, `serve`)
- **Azure AD Groups:**
  - `gp-data-engineer`: Members can ingest and curate data
  - `gp-data-analyst`: Members can consume curated data
- **Role Assignments:**
  - Data Engineers (`gp-data-engineer`): Assigned the `Storage Blob Data Contributor` role at the storage account level, granting read/write access to all containers.
  - Data Analysts (`gp-data-analyst`): Assigned the `Storage Blob Data Reader` role scoped only to the `serve` container, granting read-only access to curated data.

---

## Variables

| Name                    | Description                               | Default                               |
|-------------------------|-------------------------------------------|---------------------------------------|
| `location`              | Azure region to deploy the resources      | `westus2`                             |
| `resource_group_name`   | Name of the Resource Group                | `rg-iamexample-dev-usw2-001`         |
| `storage_account_name`  | Name of the Storage Account               | `stiamexample001`                     |
| `container_names`       | List of storage container names           | `["raw", "serve"]`                    |

---

## Outputs

| Name                         | Description                                      |
|-------------------------------|-------------------------------------------------|
| `resource_group_name`        | Name of the deployed Resource Group            |
| `storage_account_name`       | Name of the Storage Account                     |
| `storage_account_primary_endpoint` | Primary Blob endpoint of the Storage Account |
| `storage_container_names`    | List of container names created                 |
| `data_engineer_group_id`     | Object ID of the Data Engineers AAD group      |
| `data_analyst_group_id`      | Object ID of the Data Analysts AAD group       |

---

## Usage

1) Clone the repository:
    ```bash
    git clone <repo-url>
    cd <repo-directory>
    ```

2. Initialize Terraform:
    ```
    terraform init
    ```

3. Review the execution plan:
    ```
    terraform plan
    ```

4. Apply the Terraform configuration:
    ```
    terraform apply
    ```

After deployment, outputs will display resource names, endpoints, and AAD group IDs.

When done you can use `terraform destroy` to tear down any resources deployed within this Azure project.

---

## IAM Implementation Details

This module demonstrates a practical IAM pattern for data engineering in Azure:

- **Azure AD Groups:**
  - `gp-data-engineer`: For users who ingest raw data and create curated datasets.
  - `gp-data-analyst`: For users who consume curated data for analysis and reporting.
- **Role Assignments:**
  - Data Engineers are granted the `Storage Blob Data Contributor` role at the storage account scope, enabling full access to all containers.
  - Data Analysts are granted the `Storage Blob Data Reader` role scoped to the `serve` container only, restricting them to read-only access of curated data.

This separation of duties ensures that data engineers can manage and curate data, while analysts have secure, read-only access to the curated datasets.

---

## Best Practices

- Do not commit secrets or .tfstate files — use a .gitignore.
- Use remote state storage (e.g., Azure Storage Account with locking) for collaborative environments.
- Apply tags consistently for governance and cost tracking.
- Use separate environments (dev, test, prod) with appropriate naming conventions.