variable "name" {}
variable "description" {}
variable "file_path" {}
variable "runtime" {}
variable "handler" {}

variable "timeout_seconds" {
  default = 60
}

variable "event_source_arn" {}

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