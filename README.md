# terraform-ecs

## Overview
This repository provides automatic deploying with Terraform, based on infrastructure as code.

**!!Important!!** Immutable infrastructure is expected.

## Prepare
```sh
# Terraform Credentials
cp terraform.tfvars.sample terraform.tfvars
edit terraform.tfvars

# Terraform Initialize
terraform init

# Create Key Pair for deployment
ssh-keygen -t rsa
### Generating public/private rsa key pair.
### Enter file in which to save the key (*****/.ssh/id_rsa): /path/to/.ssh/deploy_key
### Enter passphrase (empty for no passphrase):  # enter without keys
### Enter same passphrase again:   # enter without keys

ls ~/.ssh/deploy_key*
# out> /path/to/ssh/hoge /path/to/ssh/hoge.pub
```

### Construct/Reconstruct of infrastructure with Terraform
```sh
# confirm resources to be create or destroy. *.tf files are automatically included.
terraform plan

terraform apply
terraform show
```

### Destroy
```
terraform plan --destroy
### terraform destroy
```