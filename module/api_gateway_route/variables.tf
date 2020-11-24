variable "apigateway_api_id" {}
variable "apigateway_integration_id" {}
variable "route_key" {
  default = "ANY /{proxy+}"
  description = "options: $default, ANY /{proxy+}, GET /execute"
}

