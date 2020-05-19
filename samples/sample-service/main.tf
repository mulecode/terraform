provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

module "context" {
  source = "github.com/mulecode/terraform.git//module/context"
  region = var.region
}

module "fargate_service" {
  source = "github.com/mulecode/terraform.git//module/fargate_service"
  service_name = var.service_name
  region = var.region
  repository = var.repository
  cluster_id = module.context.cluster_id
  vpc_id = module.context.vpc_id
  assign_public_ip = true
  subnets = module.context.public_subnets
  ecs_execution_role_arn = data.aws_iam_role.ecs_task_execution_role.arn
  lb_arn = module.context.lb_arn
  lb_path = "/"
  acm_certificate_arn = module.context.acm_certificate_arn
}

