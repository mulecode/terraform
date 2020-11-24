resource "aws_apigatewayv2_route" "main" {
  api_id = var.apigateway_api_id
  route_key = var.route_key
  target = "integrations/${var.apigateway_integration_id}"
}