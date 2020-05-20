resource "aws_api_gateway_authorizer" "cognito_auth" {
  name = "Cognito_Authorizer"
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  identity_source = "method.request.header.Authorization"
  type = "COGNITO_USER_POOLS"
  provider_arns = data.aws_cognito_user_pools.cognito_user_pool.arns
}

resource "aws_api_gateway_request_validator" "common_request_validator" {
  name = "Validate body"
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  validate_request_body = true
  validate_request_parameters = false
}

