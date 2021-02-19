data "aws_iam_policy_document" "ecs_assume_policy" {
  statement {
    actions = [
      "sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.name}-Ec2InstanceRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_policy.json
}

resource "aws_iam_policy" "ecs_ec2_policy" {
  name = "${var.name}-Ec2ContainerServicePolicy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeTags",
                "ecs:CreateCluster",
                "ecs:DeregisterContainerInstance",
                "ecs:DiscoverPollEndpoint",
                "ecs:Poll",
                "ecs:RegisterContainerInstance",
                "ecs:StartTelemetrySession",
                "ecs:UpdateContainerInstancesState",
                "ecs:Submit*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "ecs_instance_policy_attachment" {
  role = aws_iam_role.ecs_instance_role.name
  policy_arn = aws_iam_policy.ecs_ec2_policy.arn
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.name}-Ec2IamInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}
