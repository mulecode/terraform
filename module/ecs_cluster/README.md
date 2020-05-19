# ECS Cluster

Creates ECS cluster

### Sample:

```hcl-terraform
module "public_lb" {
  source = "github.com/mulecode/terraform.git//module/ecs_cluster"
  name = "services cluster"
  region = "eu-west-2"
}
```