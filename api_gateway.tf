# /
resource "aws_api_gateway_rest_api" "demo" {
  name = "demo_gateway"
  description = "Terraform Serverless Demo Application"
}

# / >> GET
resource "aws_api_gateway_method" "root" {
  rest_api_id = aws_api_gateway_rest_api.demo.id
  resource_id = aws_api_gateway_rest_api.demo.root_resource_id
  http_method = "ANY"
  authorization = "NONE"
}

# / <+++> GET
resource "aws_api_gateway_integration" "root_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.demo.id
  resource_id = aws_api_gateway_method.root.resource_id
  http_method = aws_api_gateway_method.root.http_method

  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.demo_ground.invoke_arn
}

# /author
resource "aws_api_gateway_resource" "author" {
  rest_api_id = aws_api_gateway_rest_api.demo.id
  parent_id = aws_api_gateway_rest_api.demo.root_resource_id
  path_part = "author"
}

# /authors >> POST
resource "aws_api_gateway_method" "author_post" {
  rest_api_id = aws_api_gateway_rest_api.demo.id
  resource_id = aws_api_gateway_resource.author.id
  http_method = "POST"
  authorization = "NONE"
}

# /author <+++> POST
resource "aws_api_gateway_integration" "author_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.demo.id
  resource_id = aws_api_gateway_resource.author.id
  http_method = aws_api_gateway_method.author_post.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.demo_ground.invoke_arn
}
