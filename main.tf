provider "aws" {
  access_key=""
  secret_key=""
  region="us-east-1"
  
}

# Declare the data source
#data "aws_availability_zones" "available" {}

# Declaring a new VPC (Free resource) with public subnet
module "vpc" {  
  source = "./modules/vpc"
  name = "web"
  environment = "dev"
  enable_dns_support=true
  enable_dns_hostnames=true
  vpc_cidr ="172.16.0.0/16"
        public_subnets_cidr = "172.16.10.0/24,172.16.20.0/24"
        private_subnets_cidr = "172.16.30.0/24,172.16.40.0/24"
        #azs    = "${data.aws_availability_zones.available.names[0]},${data.aws_availability_zones.available.names[1]}"
        azs    = "us-east-1a,us-east-1b"
}

# Declare the eb module 
module "eb" {
  source = "./modules/eb"
  name="eb"
  environment = "dev"
  security_group_id="${module.eb_sg.eb_sg_id}" 
  #availability_zones ="${data.aws_availability_zones.available.names[0]} , ${data.aws_availability_zones.available.names[1]}" 
  vpc_id ="${module.vpc.vpc_id}"
  subnets = "${module.vpc.public_subnets_id}"
  #instance_id="${module.web_server.instance_id}" 
}

# Declare the elastic loadbalancer security group
module "eb_sg" {
  source = "./modules/eb_sg"
  name = "eb_sg"
  environment = "dev"
  vpc_id = "${module.vpc.vpc_id}"
}
