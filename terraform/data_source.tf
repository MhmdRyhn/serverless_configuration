data "archive_file" "lambda_function_zip" {
  type = "zip"
  source_dir = "../sample_lambda"
  output_path = "../.build/lambda_function.zip"
}

data "aws_cognito_user_pools" "cognito_user_pool" {
  name = var.user_pools_name
}
