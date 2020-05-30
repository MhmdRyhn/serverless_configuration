resource "aws_lambda_function" "dummy_ground" {
  function_name = "dummy_lambda"
  description = "This is a function created using terraform during learning"
  filename = data.archive_file.lambda_function_zip.output_path
  handler = "sample.lambda_handler"
  source_code_hash = data.archive_file.lambda_function_zip.output_base64sha256
  role = aws_iam_role.dummy_role.arn
  runtime = "python3.8"
  timeout = 10
//  layers = [aws_lambda_layer_version.lambda_layers.arn]
}

# https://github.com/hashicorp/terraform/issues/9271
resource "aws_lambda_permission" "api_gateway_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dummy_ground.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* part allows invocation from any method
  # and resource path within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.dummy.execution_arn}/${var.api_stage}/*/*"
  depends_on = [
    module.api_gateway,
    aws_lambda_function.dummy_ground
  ]
}
