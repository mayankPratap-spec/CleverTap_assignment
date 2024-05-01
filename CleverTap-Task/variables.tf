variable "db_instance_class" {
  description = "The RDS instance class"
  default     = "db.t2.micro"
}

variable "db_engine" {
  description = "The database engine to use"
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The version of the database engine to use"
  default     = "8.0"
}

variable "db_allocated_storage" {
  description = "The amount of storage allocated to the DB instance, in gigabytes"
  default     = 20
}

variable "db_name" {
  description = "The name of the database"
  default     = "wordpressdb"
}

variable "db_username" {
  description = "The master username for the database"
  default     = "admin"
}

/*variable "db_password" {
  description = "The master password for the database"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}*/

variable "asg_desired_capacity" {
  type        = number
  description = "Desired capacity of the Auto Scaling Group"
  default = 2
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size of the Auto Scaling Group"
  default = 1
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size of the Auto Scaling Group"
  default = 4
}

variable "ec2_ami_id" {
  type        = string
  description = "ID of the AMI for the EC2 instances in the Auto Scaling Group"
  default = "ami-02faaf8bb6ffc8fab"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instances in the Auto Scaling Group"
  default = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair used for the EC2 instances"
  default = "linuxKeyPair"
}
