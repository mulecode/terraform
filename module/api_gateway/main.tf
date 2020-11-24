resource "aws_apigatewayv2_domain_name" "domain_name" {
  domain_name = var.api_domain

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_api" "api" {
  name = var.api_name
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id = aws_apigatewayv2_api.api.id
  auto_deploy = true
  name = var.stage_name
}

resource "aws_apigatewayv2_api_mapping" "mapping_default" {
  depends_on = [
    aws_apigatewayv2_api.api,
    aws_apigatewayv2_domain_name.domain_name,
    aws_apigatewayv2_stage.stage
  ]
  api_id = aws_apigatewayv2_api.api.id
  domain_name = aws_apigatewayv2_domain_name.domain_name.id
  stage = aws_apigatewayv2_stage.stage.id
}

resource "aws_route53_record" "record" {
  depends_on = [
    aws_apigatewayv2_domain_name.domain_name,
    aws_apigatewayv2_api_mapping.mapping_default
  ]
  name = aws_apigatewayv2_domain_name.domain_name.domain_name
  type = "A"
  zone_id = var.zone_id

  alias {
    name = aws_apigatewayv2_domain_name.domain_name.domain_name_configuration[0].target_domain_name
    zone_id = aws_apigatewayv2_domain_name.domain_name.domain_name_configuration[0].hosted_zone_id
    evaluate_target_health = false
  }
}