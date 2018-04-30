# AWS ElasticBeanstalk With Your Custom Application

## Prerequisites
-AWS IAM Role with access to IAM, EC2, Beanstalk ,VPC & S3 
-Terraform 
-AWS CLI
### Setup
1. Configure AWS CLI with Acess_key , Secret_Key and Region 
2. Run ```terraform init ```
3. Run ```terraform plan ``` - just to check what terraform goning to build
4. Run ```terraform apply ``` - this may take up to 15 minutes 
5. Run ```aws elasticbeanstalk update-environment  --application-name Test-Application  --version-label tf-test-version-label --environment-name dtcc-env ```  on cli after completion of Terrafrom Apply 
6. Done , Check out the eb dns in aws console 


### Rollbacking setup

```terraform destroy``` 