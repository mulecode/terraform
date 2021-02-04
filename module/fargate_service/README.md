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
  vpc_id = data.terraform_remote_state.context_vpc.outputs.vpc_id
  assign_public_ip = true
  subnets = data.terraform_remote_state.context_vpc.outputs.public_subnets
  ecs_execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  lb_arn = data.terraform_remote_state.fargate.outputs.lb_arn
  lb_path = "/hello"
  lb_listener_rule_priority = 100
  lb_listener_arn = aws_lb_listener.main.arn
  health_check_url_path = "/hello/actuator/health"
  acm_certificate_arn = data.terraform_remote_state.certificates.outputs.acm_certificate_arn
  container_port = 8080
  environment_variables = <<EOF
[
  {"name": "SPRING_PROFILES_ACTIVE", "value": "default"},
  {"name": "SERVER_PORT", "value": "8080"},
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
