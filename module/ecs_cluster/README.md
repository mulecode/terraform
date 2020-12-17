# ECS Cluster

Creates ECS cluster and default execution role

### Sample:

```hcl-terraform
module "mulecode_fargate_cluster" {
  source = "github.com/mulecode/terraform.git//module/ecs_cluster"
  name = "mulecode-cluster"
  region = "eu-west-2"
}
```
