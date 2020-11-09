# Lambda

Creates a lambda with trigger source [SQS, DynamoDB, etc.]

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
    },
    {
      "Effect": "Allow",
      "Action": [
          "sqs:*"
      ],
      "Resource": [
        "${module.my_sqs.sqs_arn}"
      ]
    }
  ]
}
EOF
}

module "my_sqs" {
  source = "github.com/mulecode/terraform.git//module/sqs"
  name = "my-sqs"
  visibility_timeout_seconds = 30
}

module "lambda_scheduled_sample" {
  source = "github.com/mulecode/terraform.git//module/lambda_trigger"
  name = "lambda-scheduled-name"
  file_path = local.artifact_path
  iam_policy = local.iam_policy
  runtime = "java11"
  handler = "co.uk.mulecode.ApplicationRequestHandler"
  vpc_id = var.vpc_id
  vpc_subnets = var.public_subnets
  event_source_arn = module.my_sqs.sqs_arn
  timeout_seconds = 30
  environment_variables = {
    REGION = "eu-west-2"
  }
}
```