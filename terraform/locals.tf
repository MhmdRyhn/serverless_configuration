locals {
  integration_type = {
    lambda_proxy = "AWS_PROXY"
    mock = "MOCK"
  }
  status_code = {
    success = "200"
  }
  method = {
    options = "OPTIONS"
    get = "GET"
    post = "POST"
  }
}

locals {
  integration_response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.allowed_origins
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, GET'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Requested-With,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
  method_response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}
