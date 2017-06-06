# codepipeline for build docker image


# Usage
```bash
terraform env new build-docker-image
terraform plan
terraform apply
```

edit var.tf or create var_override.tf configure github parameter




if use assumerole ,use fellow line in `provider_override.tf`
```hcl
provider "aws" {
  profile = "default"
  region  = "us-west-2"

  assume_role {
    role_arn = "arn:aws:iam::012345678912:role/rolename"
    session_name = "sessionname"
  }
}
```
