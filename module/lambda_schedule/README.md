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
  source = "github.com/mulecode/terraform.git//module/lambda_schedule"
  name = "lambda-scheduled-name"
  file_name = local.artifact_path
  source_code_hash = base64sha256(file(local.artifact_path))
  iam_policy = local.iam_policy
  runtime = "java11"
  handler = "com.acme.ApplicationRequestHandler"
  schedule_expression = "cron(0 7,19 ? * MON-FRI *)"
  environment_variables = {
    REGION = "eu-west-2"
  }
}
```