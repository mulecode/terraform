locals {
  sqs_name = var.fifo_queue ? "${var.name}.fifo" : var.name
  dlq_name = var.fifo_queue ? "${var.name}-dlq.fifo" : "${var.name}-dlq"
  redrive_policy = <<EOF
{
  "deadLetterTargetArn": "${aws_sqs_queue.dlq.arn}",
  "maxReceiveCount": ${var.maxReceiveCount}
}
EOF
}

resource "aws_sqs_queue" "dlq" {
  name = local.dlq_name
  message_retention_seconds = var.retention_seconds
  fifo_queue = var.fifo_queue
  content_based_deduplication = var.fifo_queue
}

resource "aws_sqs_queue" "sqs" {
  depends_on = [
    aws_sqs_queue.dlq
  ]
  name = local.sqs_name
  redrive_policy = local.redrive_policy
  fifo_queue = var.fifo_queue
  content_based_deduplication = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout_seconds
}

