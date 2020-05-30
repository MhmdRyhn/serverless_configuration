provider "aws" {
  region                      = var.region
  access_key                  = var.access_key
  secret_key                  = var.secret_access_key
//  skip_credentials_validation = true
//  skip_metadata_api_check     = true
//  skip_requesting_account_id  = true

//  endpoints {
//    apigateway     = "http://localhost:4567"
//    cloudformation = "http://localhost:4581"
//    cloudwatch     = "http://localhost:4582"
//    dynamodb       = "http://localhost:4569"
//    ec2            = "http://localhost:4597"
//    es             = "http://localhost:4578"
//    firehose       = "http://localhost:4573"
//    iam            = "http://localhost:4593"
//    kinesis        = "http://localhost:4568"
//    lambda         = "http://localhost:4574"
//    route53        = "http://localhost:4580"
//    redshift       = "http://localhost:4577"
//    s3             = "http://localhost:4572"
//    secretsmanager = "http://localhost:4584"
//    ses            = "http://localhost:4579"
//    sns            = "http://localhost:4575"
//    sqs            = "http://localhost:4576"
//    ssm            = "http://localhost:4583"
//    stepfunctions  = "http://localhost:4585"
//    sts            = "http://localhost:4592"
//  }
}

module "api_gateway" {
  source = "./gateway/auth_gateway"
  rest_api_id = aws_api_gateway_rest_api.dummy.id
  api_stage = var.api_stage
  parent_resource_id = aws_api_gateway_rest_api.dummy.root_resource_id
  allowed_origins = var.allowed_origins
  auth_lambda_function_name = "dummy_lambda"
}
