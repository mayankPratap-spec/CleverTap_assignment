variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the Auto Scaling Group"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired capacity of the Auto Scaling Group"
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
}

variable "ec2_ami_id" {
  type        = string
  description = "ID of the AMI for the EC2 instances in the Auto Scaling Group"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instances in the Auto Scaling Group"
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair used for the EC2 instances"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs where the Auto Scaling Group instances will be launched"
}

variable "target_group_arns" {
  type = list(string)
  description = "target group arn"
}

variable "security_group_ids" {
  type    = list(string)
}

variable "db_name" {
  description = "The name of the RDS database"
  type = string
}

variable "db_user" {
  description = "The username for the RDS database"
  type = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type = string
}

variable "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  type        = string
}

/*
variable "new_hostname" {
 description = "represents the host name of the instance"
 type = string
}*/