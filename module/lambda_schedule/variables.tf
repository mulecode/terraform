variable "name" {}
variable "description" {}
variable "file_path" {}
variable "runtime" {}
variable "handler" {}
variable "vpc_id" {}
variable "vpc_subnets" {
  type = list(string)
}

variable "timeout_seconds" {
  default = 60
}

variable "memory_size" {
  default = 254
}

variable "schedule_expression" {}

variable "concurrent_executions" {
  default = -1
  description = "0 disables lambda from being triggered and -1 removes any concurrency limitations"
}

variable "environment_variables" {
  type = map(string)
  default = {}
}

variable "iam_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}