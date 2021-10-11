# Deploying a Website to AWS with Terraform
\
![GitHub](/img/architecture.svg)

## Config
- Add your AWS credentials in the following variables within variables.tf

	- user_information 
	- layer 
	- aliases 
	- domain_name 


## Deploying

```bash
$ terraform init
$ terraform apply
```

## Last steps

- Configure your DNS
- Upload your website to the bucket s3

Using:
* [x] [Terraform](https://www.terraform.io/)

<img src="https://www.datocms-assets.com/2885/1629941242-logo-terraform-main.svg" width="200">

Autor:
*  [GitHub](https://github.com/caaguirre194)
	 @caaguirre194
