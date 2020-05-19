provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    encrypt = true
  }
}

data "aws_route53_zone" "selected" {
  name = var.domainName
}

module "vpc_public" {
  source = "github.com/mulecode/terraform.git//module/vpc_public"
  name = var.name
  cidr = var.cidr
  region = var.region
}

module "fargate_cluster" {
  source = "github.com/mulecode/terraform.git//module/ecs_cluster"
  name = var.name
  region = var.region
}

module "public_lb" {
  source = "github.com/mulecode/terraform.git//module/loadbalancer"
  name = var.name
  zoneId = data.aws_route53_zone.selected.id
  subnets = module.vpc_public.public_subnets
  vpc_id = module.vpc_public.vpc_id
  domainName = var.lbDomainName
}

resource "aws_acm_certificate" "cert" {
  domain_name = "*.${var.domainName}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}