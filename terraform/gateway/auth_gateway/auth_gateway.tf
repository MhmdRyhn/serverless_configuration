# ------------ Resource: /auth -------------------
resource "aws_api_gateway_resource" "auth" {
  rest_api_id = var.rest_api_id
  parent_id = var.parent_resource_id
  path_part = "auth"
}

# ------------ Resource: /auth/{userType} -------------------
resource "aws_api_gateway_resource" "user_auth" {
  rest_api_id = var.rest_api_id
  parent_id = aws_api_gateway_resource.auth.id
  path_part = "{userType}"
}
