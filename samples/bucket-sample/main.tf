variable "region" {}

provider "aws" {
  region = var.region
}

terraform {
  backend "local" {}
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "main" {
  bucket = "terraform-${data.aws_caller_identity.current.account_id}"
  acl = "private"

  tags = {
    Name = "terraform state bucket"
  }
}