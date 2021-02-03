# Fargate Service

Creates a fargate task service


Sample:

```hcl-terraform
module "fargate_service" {
  source = "github.com/mulecode/terraform.git//module/fargate_service"
  service_name = "my-service"
  region = var.region
  repository_name = "hello-service"
  repository_image = "******.dkr.ecr.*****.amazonaws.com/hello-service"
  repository_version = "latest"
  cluster_id = module.context.cluster_id
  vpc_id = module.context.vpc_id
  assign_public_ip = true
  subnets = module.context.public_subnets
  ecs_execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  lb_arn = module.context.lb_arn
  lb_path = "/hello"
  health_check_url_path = "/hello/actuator/health"
  acm_certificate_arn = module.context.acm_certificate_arn
  container_port = 8080
  environment_variables = <<EOF
[
  {"name": "SPRING_PROFILES_ACTIVE", "value": "default"},
  {"name": "SERVER_SERVLET_CONTEXT-PATH", "value": "/hello"}
]
EOF
}
```


### Properties

#### ecs_execution_role_arn

Default role for task execution

```hcl-terraform
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}
```
