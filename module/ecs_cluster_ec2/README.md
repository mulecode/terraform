# ECS Cluster EC2

Creates ECS cluster

### Sample:

```hcl-terraform
module "mulecode_fargate_cluster" {
  source = "github.com/mulecode/terraform.git//module/ecs_cluster_ec2"
  name = "mulecode-cluster"
  vpc_id = data.terraform_remote_state.context_vpc.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.context_vpc.outputs.public_subnets
}
```
