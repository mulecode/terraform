resource "aws_lambda_permission" "lambda_permission" {
  action = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.apigateway_execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id = var.apigateway_id
  integration_type = "AWS_PROXY"

  description = "Lambda GET integration"
  integration_method = "POST"
  integration_uri = var.lambda_invoke_arn
  payload_format_version = "2.0"
}