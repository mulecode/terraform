# VPC public

Creates a 3 zoned public VPC


Sample:

```hcl-terraform
module "vpc_public" {
  source = "github.com/mulecode/terraform.git//module/vpc_public"
  name = "mulecode"
  cidr = "172.10.0.0/20"
  region = "eu-west-2"
}
```