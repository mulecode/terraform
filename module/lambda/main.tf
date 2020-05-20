resource "aws_lambda_function" "main" {
  function_name = var.name
  role = aws_iam_role.main.arn
  filename = var.file_name
  source_code_hash = var.source_code_hash
  runtime = var.runtime
  handler = var.handler
  timeout = 300
  memory_size = 256

  environment {
    variables = var.environment_variables
  }
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
  policy = var.policy
//  policy = <<EOF
//{
//    "Version": "2012-10-17",
//    "Statement": [
//        {
//            "Effect": "Allow",
//            "Action": [
//                "logs:CreateLogGroup",
//                "logs:CreateLogStream",
//                "logs:PutLogEvents"
//            ],
//            "Resource": "*"
//        },
//        {
//          "Effect": "Allow",
//          "Action": [
//            "secretsmanager:GetSecretValue"
//          ],
//          "Resource": "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${local.secret_name}*"
//        }
//    ]
//}
//EOF
}