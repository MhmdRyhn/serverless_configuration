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
  allowed_headers_for_auth = "'Content-Type,Authorization,X-Requested-With,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
  allowed_headers_without_auth = "'Content-Type,X-Requested-With,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'"
}

locals {
  integration_response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.allowed_origins
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, POST'"
    "method.response.header.Access-Control-Allow-Headers" = local.allowed_headers_without_auth
  }
  method_response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

