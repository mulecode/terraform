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

resource "aws_lambda_event_source_mapping" "main" {
  batch_size = 1
  event_source_arn = var.event_source_arn
  enabled = true
  function_name = module.lambda.lambda_arn
}