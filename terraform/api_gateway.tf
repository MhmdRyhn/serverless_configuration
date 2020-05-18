# https://learn.hashicorp.com/terraform/aws/lambda-api-gateway
# https://github.com/hashicorp/terraform/issues/9271


# ------------------ Resource: / ---------------------
resource "aws_api_gateway_rest_api" "dummy" {
  name = var.api_gateway_name
  description = var.api_gateway_description
}

# GET -> Request Method
resource "aws_api_gateway_method" "root_get" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = "GET"
  authorization = "NONE"
}

# GET -> Integration Request
resource "aws_api_gateway_integration" "root_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_method.root_get.resource_id
  http_method = aws_api_gateway_method.root_get.http_method

  integration_http_method = local.lambda_proxy_integration_method
  type = local.lambda_proxy_integration_type
  uri = aws_lambda_function.dummy_ground.invoke_arn
}

# GET -> Method Response
resource "aws_api_gateway_method_response" "root_get_response_200" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root_get.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
}

# / -> Deploy API
resource "aws_api_gateway_deployment" "root_deploy_dev" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  stage_name = var.api_stage
  depends_on = [
    aws_api_gateway_integration.root_get_integration,
    aws_api_gateway_method_response.root_get_response_200
  ]
  variables = {
    deployed_at = timestamp()
  }
}

/*
resource "aws_api_gateway_integration_response" "root_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root_get.http_method
  status_code = aws_api_gateway_method_response.root_get_response_200.status_code
  response_templates = {
    "application/json" = ""
  }
  depends_on = [
    aws_api_gateway_integration.root_get_integration
  ]

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/xml" = <<EOF
#set($inputRoot = $input.path('$'))
<?xml version="1.0" encoding="UTF-8"?>
<message>
    $inputRoot.body
</message>
EOF
  }
}
*/


# ------------------------ Resource: /{username} -----------------------------

