# api_gateway

Module that creates apigatewayV2.

### Usage

```hcl-terraform
module "apigateway_api" {
  source = "github.com/mulecode/terraform.git//module/api_gateway" 
  api_name = "mulecode-api"
  api_domain = "api.${var.domain_name}"
  zone_id = data.aws_route53_zone.selected.zone_id
  certificate_arn = data.aws_acm_certificate.cert.arn
}
```

### Requirements

Get the selected zoneId:

```hcl-terraform
data "aws_route53_zone" "selected" {
  name = var.domain_name
}
```

Create a certificate to validate your domain

```hcl-terraform
resource "aws_acm_certificate" "cert" {
  domain_name = "*.${var.domain_name}"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
```