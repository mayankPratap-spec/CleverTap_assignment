# modules/sg/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created."
}

variable "ec2_security_group_name" {
  description = "The name of the security group for EC2 instances."
  type        = string
}

variable "rds_security_group_name" {
  description = "The name of the security group for RDS instances."
  type        = string
}

variable "alb_security_group_name" {
  description = "The name of the security group for EC2 instances."
  type        = string
}
