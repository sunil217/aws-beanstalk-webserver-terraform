resource "aws_s3_bucket" "mybucket" {
  bucket = "dtcc-env-${uuid()}"
}

resource "aws_s3_bucket_object" "myobject" {
  bucket = "${aws_s3_bucket.mybucket.id}"
  key    = "beanstalk/index.zip"
  source = "index.zip"
}

# The elastic beanstalk application
resource "aws_elastic_beanstalk_application" "webapp" {
  name = "Test-Application"
  description = "Test Application"
}

# The test environment
resource "aws_elastic_beanstalk_environment" "dtcc-env" {
  name                  = "dtcc-env"
  application           = "${aws_elastic_beanstalk_application.webapp.name}"
  solution_stack_name   = "64bit Amazon Linux 2017.09 v2.6.6 running PHP 7.1"
  tier                  = "WebServer"


  # This is the VPC that the instances will use.
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc_id}"
  }

  # This is the subnets for the instances.
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${var.subnets}"
  }
 
  # You can set the environment type, single or LoadBalanced
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  # Example of setting environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_ENVIRONMENT"
    value     = "test"
  }

}
resource "aws_elastic_beanstalk_application_version" "latest" {
  name        = "tf-test-version-label"
  application = "Test-Application"
  description = "application version created by terraform"
  bucket      = "${aws_s3_bucket.mybucket.id}"
  key         = "${aws_s3_bucket_object.myobject.id}"
}

