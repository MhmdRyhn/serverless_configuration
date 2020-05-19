locals {
  lambda_proxy_integration_method = "POST"
  lambda_proxy_integration_type = "AWS_PROXY"
  mock_integration_type = "MOCK"
  status_code = {
    success = "200"
  }
  method = {
    options = "OPTIONS"
    get = "GET"
    post = "POST"
  }
}

