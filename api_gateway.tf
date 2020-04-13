# /
resource "aws_api_gateway_rest_api" "dummy" {
  name = "dummy_gateway"
  description = "Terraform Serverless Demo Application"
}

# / >> GET
resource "aws_api_gateway_method" "root" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = "GET"
  authorization = "NONE"
}

# / <+++> GET
resource "aws_api_gateway_integration" "root_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_method.root.resource_id
  http_method = aws_api_gateway_method.root.http_method

  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = aws_lambda_function.dummy_ground.invoke_arn
}

//# /author
//resource "aws_api_gateway_resource" "author" {
//  rest_api_id = aws_api_gateway_rest_api.dummy.id
//  parent_id = aws_api_gateway_rest_api.dummy.root_resource_id
//  path_part = "author"
//}
//
//# /authors >> POST
//resource "aws_api_gateway_method" "author_post" {
//  rest_api_id = aws_api_gateway_rest_api.dummy.id
//  resource_id = aws_api_gateway_resource.author.id
//  http_method = "POST"
//  authorization = "NONE"
//}
//
//# /author <+++> POST
//resource "aws_api_gateway_integration" "author_post_integration" {
//  rest_api_id = aws_api_gateway_rest_api.dummy.id
//  resource_id = aws_api_gateway_resource.author.id
//  http_method = aws_api_gateway_method.author_post.http_method
//  integration_http_method = "POST"
//  type = "AWS_PROXY"
//  uri = aws_lambda_function.dummy_ground.invoke_arn
//}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "root_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  http_method = aws_api_gateway_method.root.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code

  # Transforms the backend JSON response to XML
//  response_templates = {
//    "application/xml" = <<EOF
//#set($inputRoot = $input.path('$'))
//<?xml version="1.0" encoding="UTF-8"?>
//<message>
//    $inputRoot.body
//</message>
//EOF
//  }
}

resource "aws_api_gateway_deployment" "dev_deployment" {
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  stage_name = "dev"
  depends_on = [aws_api_gateway_integration.root_get_integration]
  variables = {
    deployed_at = timestamp()
  }
}
