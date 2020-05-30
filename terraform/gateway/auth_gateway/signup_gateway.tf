# -------------- Resource: /auth/{userType}/signup --------------
resource "aws_api_gateway_resource" "signup" {
  rest_api_id = var.rest_api_id
  parent_id = aws_api_gateway_resource.user_auth.id
  path_part = "signup"
}

# ---> OPTIONS

# /auth/{userType}/signup OPTIONS -> Method Request
resource "aws_api_gateway_method" "signup_options" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = local.method.options
  authorization = "None"
}

# /auth/{userType}/signup OPTIONS -> Integration Request
resource "aws_api_gateway_integration" "signup_options_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.signup_options.http_method
  type = local.integration_type.mock
  request_templates = {
    "application/json" = "Empty"
  }

  depends_on = [
    aws_api_gateway_method.signup_options]
}

# /auth/{userType}/signup OPTIONS -> Method Response
resource "aws_api_gateway_method_response" "signup_options_method_response_200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.signup_options.http_method
  status_code = local.status_code.success
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = local.method_response_parameters

  depends_on = [
    aws_api_gateway_method.signup_options
  ]
}

# /auth/{userType}/signup OPTIONS -> Integration Response
resource "aws_api_gateway_integration_response" "signup_options_integration_renponse_200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method_response.signup_options_method_response_200.http_method
  status_code = aws_api_gateway_method_response.signup_options_method_response_200.status_code
  response_parameters = local.integration_response_parameters

  depends_on = [
    aws_api_gateway_integration.signup_options_integration,
    aws_api_gateway_method_response.signup_options_method_response_200
  ]
}

# ---> POST

# /auth/{userType}/signup POST -> Method Request
resource "aws_api_gateway_method" "signup_post" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = local.method.post
  authorization = "NONE"
}

# /auth/{userType}/signup POST -> Integration Request
resource "aws_api_gateway_integration" "signup_post_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.signup_post.http_method
  integration_http_method = local.method.post
  type = local.integration_type.lambda_proxy
  uri = data.aws_lambda_function.auth_lambda.invoke_arn
}

# /auth/{userType}/signup POST -> Method Response
resource "aws_api_gateway_method_response" "signup_post_method_response_200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.signup_post.http_method
  status_code = local.status_code.success
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
  depends_on = [
    aws_api_gateway_method.signup_post
  ]
}

# /auth/{userType}/signup POST -> Integration Response
resource "aws_api_gateway_integration_response" "signup_post_integration_response_200" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method_response.signup_post_method_response_200.http_method
  status_code = aws_api_gateway_method_response.signup_post_method_response_200.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = var.allowed_origins
    "method.response.header.Access-Control-Allow-Headers" = local.allowed_headers_without_auth
  }

  depends_on = [
    aws_api_gateway_integration.signup_post_integration,
    aws_api_gateway_method_response.signup_post_method_response_200
  ]
}

# /auth/{userType}/signup -> Deploy API
resource "aws_api_gateway_deployment" "signup_deploy_dev" {
  rest_api_id = var.rest_api_id
  stage_name = var.api_stage
  variables = {
    deployed_at = timestamp()
  }

  depends_on = [
    aws_api_gateway_integration.signup_options_integration,
    aws_api_gateway_integration.signup_post_integration,
  ]
}

