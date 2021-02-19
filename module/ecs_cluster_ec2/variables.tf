variable "name" {}

variable "vpc_id" {}

variable "subnet_ids" {
  type = list(string)
}

variable "containerInsights" {
  default = "disabled"
}

variable "image_id" {
  description = "the ecs optimized AMI to use in the cluster"
  default = "ami-0b1e455c3dd6f4b3f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "desired_capacity" {
  default = 2
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 10
}
