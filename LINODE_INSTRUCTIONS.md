# Linode Instructions

### Steps:
1. **Install Terraform**: Ensure Terraform is installed on your system.
2. **Create Linode API Token**: Obtain a personal access token from Linode's cloud manager.
3. **Set up the Terraform configuration**: `linode.tf`

### List linodes

```sh
linode-cli linodes list
```

```sh
linode-cli regions list
```

### Instructions:
1. **Initialize Terraform**:
```bash
terraform init
```

### Set Linode Token
Export your Linode token as an environment variable or provide it as a `terraform.tfvars` file:
```hcl
linode_token = "xtoken"
```
