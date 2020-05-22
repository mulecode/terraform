# Lambda

Creates a lambda

java usage:

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

module "lambda_sample" {
  source = "github.com/mulecode/terraform.git//module/lambda"
  name = "lambda-name"
  file_path = local.artifact_path
  iam_policy = local.iam_policy
  runtime = "java11"
  handler = "com.acme.ApplicationRequestHandler"
  environment_variables = {
    REGION = "eu-west-2"
  }
}
```

python usage:

```hcl-terraform

module "lambda_python_sample" {
  source = "github.com/mulecode/terraform.git//module/lambda"
  name = "lambda-python-name"
  file_path = data.archive_file.main.output_path
  iam_policy = local.iam_policy
  runtime = "python3.7"
  handler = "handler.handler"
  environment_variables = {
    REGION = "eu-west-2"
  }
}

data "archive_file" "main" {
  type        = "zip"
  source_dir  = "../code/python/out"
  output_path = "${path.module}/lambda-python-name.zip"
}
```