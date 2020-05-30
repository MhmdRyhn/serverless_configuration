data "aws_lambda_function" "auth_lambda" {
  function_name = var.auth_lambda_function_name
}
