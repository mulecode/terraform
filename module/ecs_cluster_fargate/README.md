# ECS Cluster Fargate

Creates ECS cluster

### Sample:

```hcl-terraform
module "mulecode_fargate_cluster" {
  source = "github.com/mulecode/terraform.git//module/ecs_cluster_fargate"
  name = "mulecode-cluster"
}
```
