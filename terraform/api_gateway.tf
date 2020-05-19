# https://learn.hashicorp.com/terraform/aws/lambda-api-gateway
# https://github.com/hashicorp/terraform/issues/9271


# ------------------ Resource: / ---------------------
resource "aws_api_gateway_rest_api" "dummy" {
  name = var.api_gateway_name
  description = var.api_gateway_description
}

# / OPTIONS -> Method Request
resource "aws_api_gateway_method" "root_options" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = local.method.options
  authorization = "None"
}

# / OPTIONS -> Integration Request
resource "aws_api_gateway_integration" "root_option_integration" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root_options.http_method

  integration_http_method = local.lambda_proxy_integration_method
  type = local.mock_integration_type
  depends_on = [aws_api_gateway_method.root_options]
}

# / OPTIONS -> Method Response
resource "aws_api_gateway_method_response" "root_option_response_200" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root_options.http_method
  status_code = local.status_code.success
  response_models = {
    "Application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  depends_on = [aws_api_gateway_integration.root_option_integration]
}

# / OPTIONS -> Integration Response
resource "aws_api_gateway_integration_response" "root_option_integration_renponse_200" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method_response.root_option_response_200.http_method
  status_code = aws_api_gateway_method_response.root_option_response_200.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS, GET'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Requested-With,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
  }
  depends_on = [aws_api_gateway_integration.root_option_integration]
}

# / GET -> Method Request
resource "aws_api_gateway_method" "root_get" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = local.method.get
  authorization = "NONE"
}

# / GET -> Integration Request
resource "aws_api_gateway_integration" "root_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_method.root_get.resource_id
  http_method = aws_api_gateway_method.root_get.http_method

  integration_http_method = local.lambda_proxy_integration_method
  type = local.lambda_proxy_integration_type
  uri = aws_lambda_function.dummy_ground.invoke_arn
}

# / GET -> Method Response
resource "aws_api_gateway_method_response" "root_get_response_200" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root_get.http_method
  status_code = local.status_code.success
  response_models = {
    "application/json" = "Empty"
  }
}

# / -> Deploy API
resource "aws_api_gateway_deployment" "root_deploy_dev" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  stage_name = var.api_stage
  depends_on = [
    aws_api_gateway_integration.root_option_integration,
    aws_api_gateway_integration.root_get_integration,
  ]
  variables = {
    deployed_at = timestamp()
  }
}



# ------------------------ Resource: /{username} -----------------------------

