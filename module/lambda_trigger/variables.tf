variable "name" {}
variable "file_name" {}
variable "source_code_hash" {}
variable "runtime" {}
variable "handler" {}
variable "event_source_arn" {}

variable "environment_variables" {
  type = "map"
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