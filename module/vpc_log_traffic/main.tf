resource "aws_flow_log" "main" {
  iam_role_arn = "${aws_iam_role.main.arn}"
  log_destination = "${aws_cloudwatch_log_group.main.arn}"
  vpc_id = var.vpcId
  traffic_type = "ALL"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "${var.name}-${var.vpcId}-flow-logs"
}

resource "aws_iam_role" "main" {
  name = "${var.name}-flow-logs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main" {
  name = "${var.name}-flow-logs"
  role = "${aws_iam_role.main.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}