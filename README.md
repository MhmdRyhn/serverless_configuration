# serverless_configuration
Serverless application configuration using AWS Lambda, API Gateway and Cognito. Configuration language used here is Terraform.


# Commands To Manipulate Resources
- **View execution plan**
```
terraform plan --var-file input.tfvars
```

- **Apply the configurations** 
```
terraform apply --var-file input.tfvars --auto-approve
```
Remove `--auto-approve` option from the above command to approve manually (by inputting prompt).

- **Destroy all resources**
```
terraform destroy --var-file input.tfvars --auto-approve
```
Remove `--auto-approve` option from the above command to approve manually (by inputting prompt).
