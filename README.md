# ec2-instance

This module has been created for answering the need of normalization on instance creation via Terraform as for Monitoring, Naming, Log-Shipping, Decommissioning,...


Any instance created in the Fraugster Context via Terraform should be using this module.

## Set Version Tag on Usable new Release

### Annotated tag
> git tag -a v1.0.0 -m ‘Version 1.0.0’    
> git tag    
> git push origin --tags    

## Module Call from Terraform

Call of module should be done as described below:
```
module "vpc" {
  source = "git::git@gitlab.n0q.eu:terraform-modules/frg-ec2-instance.git?ref=v1.0.0"
}
```

