resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.name}-ExecutionRole"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecs_execution_policy" {
  name = "${var.name}-ExecutionPolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": [
        "ecs:DescribeClusters",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetRepositoryPolicy",
        "ecr:DescribeRepositories",
        "ecr:ListImages",
        "ecr:DescribeImages",
        "ecr:BatchGetImage"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ecs_execution_policy_attachment" {
  name = "${var.name}-ExecutionAttachment"
  policy_arn = aws_iam_policy.ecs_execution_policy.arn
  roles = [
    aws_iam_role.ecs_execution_role.name,
  ]
}
