output "sqs_arn" {
  value = aws_sqs_queue.sqs.arn
}

output "sqs_name" {
  value = aws_sqs_queue.sqs.name
}

output "sqs_dlq_arn" {
  value = aws_sqs_queue.dlq.arn
}

output "sqs_dlq_name" {
  value = aws_sqs_queue.dlq.name
}