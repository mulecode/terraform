variable "name" {}
variable "file_name" {}
variable "source_code_hash" {}
variable "runtime" {}
variable "handler" {}
variable "schedule_expression" {}

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