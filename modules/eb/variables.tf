variable "name" {
  default = "test"
}

variable "environment" {
  default = "test"
}

variable "vpc_id" {
  
}

variable "subnets" {
  description = "Subnets for EB"
}

variable "security_group_id" {
  description = "Security groups for eb"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
  default = "0.0.0.0/0"
}