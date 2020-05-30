variable "rest_api_id" {
  type = string
  description = "ID of the REST API."
}

variable "api_stage" {
  type = string
  description = "API stage, e.g., dev, test, prod etc."
  default = "dev"
}

variable "parent_resource_id" {
  type = string
  description = "ID of the parent resouce."
}

variable "allowed_origins" {
  type = string
  description = "A comma separated string of hosts that are allowed to request in the API Gateway."
  default = "'*'"
}

variable "auth_lambda_function_name" {
  type = string
  description = "Name of the auth lambda function, e.g., AuthLambda."
}
