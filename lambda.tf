resource "aws_lambda_function" "demo_ground" {
  function_name = "terraground"
  description = "This is a function created using terraform during learning"
  filename = data.archive_file.lambda_function_zip.output_path
  handler = "sample.lambda_handler"
  source_code_hash = data.archive_file.lambda_function_zip.output_base64sha256
  role = aws_iam_role.demo_role.arn
  runtime = "python3.8"
  timeout = 10
//  layers = [aws_lambda_layer_version.lambda_layer_marshmallow.arn]
}
