# Lambda

Creates a lambda with schedule expression

usage:

```hcl-terraform
locals {
 artifact_path = "../builds/out/artifact.zip"
 iam_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeInstances",
        "ec2:AttachNetworkInterface"
      ],
      "Resource": "*"
    },
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

module "lambda_scheduled_sample" {
  source = "github.com/mulecode/terraform.git//module/lambda_schedule"
  name = "lambda-scheduled-name"
  file_path = local.artifact_path
  iam_policy = local.iam_policy
  runtime = "java11"
  handler = "co.uk.mulecode.ApplicationRequestHandler"
  vpc_id = var.vpc_id
  vpc_subnets = var.public_subnets
  schedule_expression = "cron(0 7,19 ? * MON-FRI *)"
  environment_variables = {
    REGION = "eu-west-2"
  }
}
```