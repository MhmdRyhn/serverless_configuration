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