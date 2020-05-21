locals {
  sqs_name = var.fifo_queue ? "${var.name}.fifo" : var.name
}

resource "aws_sqs_queue" "sqs" {
  name = local.sqs_name
  fifo_queue = var.fifo_queue
  content_based_deduplication = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout_seconds
}

