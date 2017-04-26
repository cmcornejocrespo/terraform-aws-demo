# terraform-aws-demo
Terraform-related code for AWS used in enmilocalfunciona.io

#What is this?

This is the terraform code that backs up the blog entry in enmilocalfunciona.
Provisions a very simple infrastructure composed by:
- VPC
- subnet
- IGW and outer internet access

## Requirements
- Terraform 0.9.4+, install [here](https://www.terraform.io/downloads.html)
- AWS access configured via IAM role or aws_access_key_id, aws_secret_access_key credentials

# Usage

Check status
```sh
$ terraform plan 
```

Builds infrastructure

```sh
$ terraform apply
```

Destroy infrastructure

```sh
$ terraform destroy
```
