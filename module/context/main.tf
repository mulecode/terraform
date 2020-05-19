variable "region" {
  default = "eu-west-2"
}

variable "state_file_path" {
  default = "infrastructure/main.tfstate"
}

variable "state_bucket_id" {
  default = ""
}

provider "aws" {
  region = var.region
}

locals {
  state_bucket_name = var.state_bucket_id == "" ? "terraform" : var.state_bucket_id
  state_bucket = "${local.state_bucket_name}-${data.aws_caller_identity.current.account_id}"
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "context" {
  backend = "s3"

  config = {
    bucket = local.state_bucket
    key = var.state_file_path
    region = var.region
  }
}

output "cluster_id" {
  value = data.terraform_remote_state.context.outputs.cluster_id
}

output "cluster_arn" {
  value = data.terraform_remote_state.context.outputs.cluster_arn
}

output "vpc_id" {
  value = data.terraform_remote_state.context.outputs.vpc_id
}

output "public_subnets" {
  value = data.terraform_remote_state.context.outputs.public_subnets
}

output "zoneId" {
  value = data.terraform_remote_state.context.outputs.zoneId
}

output "zoneIdName" {
  value = data.terraform_remote_state.context.outputs.zoneIdName
}

output "lb_id" {
  value = data.terraform_remote_state.context.outputs.lb_id
}

output "lb_arn" {
  value = data.terraform_remote_state.context.outputs.lb_arn
}

output "lb_name" {
  value = data.terraform_remote_state.context.outputs.lb_name
}

output "acm_certificate_id" {
  value =  data.terraform_remote_state.context.outputs.acm_certificate_id
  sensitive = true
}

output "acm_certificate_arn" {
  value = data.terraform_remote_state.context.outputs.acm_certificate_arn
}