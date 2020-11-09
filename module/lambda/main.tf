resource "aws_lambda_function" "main" {
  function_name = var.name
  description = var.description
  role = aws_iam_role.main.arn
  filename = var.file_path
  source_code_hash = base64sha256(filebase64(var.file_path))
  runtime = var.runtime
  handler = var.handler
  timeout = var.timeout_seconds
  memory_size = var.memory_size
  reserved_concurrent_executions = var.concurrent_executions

  vpc_config {
    security_group_ids = [
      aws_security_group.main.id
    ]
    subnet_ids = var.vpc_subnets
  }

  environment {
    variables = var.environment_variables
  }

  depends_on = [
    aws_iam_policy_attachment.main,
    aws_cloudwatch_log_group.main
  ]
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/lambda/${var.name}"
  retention_in_days = 7
}

resource "aws_iam_policy_attachment" "main" {
  name = var.name
  policy_arn = aws_iam_policy.main.arn

  roles = [
    aws_iam_role.main.name
  ]
}

resource "aws_iam_role" "main" {
  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "main" {
  name = var.name
  policy = var.iam_policy
}

resource "aws_security_group" "main" {
  name = var.name
  vpc_id = var.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}