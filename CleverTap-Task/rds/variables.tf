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

variable "db_password" {
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
}

variable "rds_security_group_ids" {
  description = "sg id for rds instance"
  type = list(string)
}