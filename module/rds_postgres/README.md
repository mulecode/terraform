# RDS Postgres

Creates a RDS postgres database


Sample:

```hcl-terraform
module "rds" {
  source = "github.com/mulecode/terraform.git//module/rds_postgres"
  db_identifier = "${var.name}-db"
  subnets = module.context.public_subnets
  vpc_id = module.context.vpc_id
  inbound_security_groups        = ["${module.service.task_security_group_id}"]
}
```