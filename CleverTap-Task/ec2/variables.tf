variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-12345678"  # Change this to your desired AMI ID
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones for EC2 instances"
  type        = list(string)
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair used for the EC2 instances"
  default = "linuxKeyPair"
}