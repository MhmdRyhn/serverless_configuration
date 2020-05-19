variable "region" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_access_key" {
  type = string
}

variable "api_gateway_name" {
  type = string
  description = "Name of the API Gateway"
  default = "dummy-api-gateway"
}

variable "api_gateway_description" {
  type = string
  description = "Description of the API Gateway"
  default = "Serverless Application"
}

variable "api_stage" {
  type = string
  description = "API stage, e.g., dev, test, prod etc."
  default = "dev"
}

variable "allowed_origins" {
  type = string
  description = "A comma separated string of hosts that are allowed to request in the API Gateway."
  default = "'*'"
}
