# api_gateway_lambda_integration

Module that creates apigatewayV2 lambda integration

### Usage

```hcl-terraform
module "lambda_integration" {
  source = "github.com/mulecode/terraform.git//module/api_gateway_lambda_integration"
  depends_on = [
    module.lambda_function_sample]
  apigateway_id = module.apigateway_api.api_id
  apigateway_execution_arn = module.apigateway_api.api_execution_arn
  lambda_arn = module.lambda_function.lambda_arn
  lambda_invoke_arn = module.lambda_function.lambda_invoke_arn
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

Lambda

```hcl-terraform
module "lambda_function" {
  source = "github.com/mulecode/terraform.git//module/lambda"
  name = var.function_name
  ...
}
```