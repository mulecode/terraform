module "lambda" {
  source = "github.com/mulecode/terraform.git//module/lambda"
  name = var.name
  description = var.description
  file_path = var.file_path
  iam_policy = var.iam_policy
  runtime = var.runtime
  handler = var.handler
  timeout_seconds = var.timeout_seconds
  vpc_id = var.vpc_id
  vpc_subnets = var.vpc_subnets
  environment_variables = var.environment_variables
  memory_size = var.memory_size
  concurrent_executions = var.concurrent_executions
}

resource "aws_cloudwatch_event_rule" "main" {
  name = "${var.name}_schedule"
  description = "Scheduled trigger for ${var.name}"
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "main" {
  rule = aws_cloudwatch_event_rule.main.name
  arn = module.lambda.lambda_arn
  target_id = "lambda"
}

resource "aws_lambda_permission" "cloudwatch_schedule" {
  function_name = module.lambda.lambda_function_name
  source_arn = aws_cloudwatch_event_rule.main.arn
  statement_id = "Schedule"
  action = "lambda:InvokeFunction"
  principal = "events.amazonaws.com"
}
