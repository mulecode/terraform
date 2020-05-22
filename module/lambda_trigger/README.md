# Lambda

Creates a lambda

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
  source = "github.com/mulecode/terraform.git//module/lambda_trigger"
  name = "lambda-scheduled-name"
  file_path = local.artifact_path
  iam_policy = local.iam_policy
  runtime = "java11"
  handler = "com.acme.ApplicationRequestHandler"
  event_source_arn = "Source ARN [SQS|DynamoDB|kinesis]"
  environment_variables = {
    REGION = "eu-west-2"
  }
}
```