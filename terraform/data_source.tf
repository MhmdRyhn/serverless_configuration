data "archive_file" "lambda_function_zip" {
  type = "zip"
  source_dir = "../sample_lambda"
  output_path = "../.build/lambda_function.zip"
}
