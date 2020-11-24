# api_gateway_route

Module that creates apigatewayV2 route

### Usage

```hcl-terraform
module "route_default" {
  source = "github.com/mulecode/terraform.git//module/api_gateway_route"
  depends_on = [
    module.lambda_integration]
  apigateway_api_id = module.apigateway_api.api_id
  apigateway_integration_id = module.lambda_integration.apigateway_integration_id
  route_key = "ANY /{proxy+}"
}
```

### Requirements

A created api gateway

```hcl-terraform
module "apigateway_api" {
  source = "github.com/mulecode/terraform.git//module/api_gateway" 
  api_name = "mulecode-api"
  ...
}
```

An apigateway integration

```hcl-terraform
module "lambda_integration" {
  source = "github.com/mulecode/terraform.git//module/api_gateway_lambda_integration"
  ...
}
```