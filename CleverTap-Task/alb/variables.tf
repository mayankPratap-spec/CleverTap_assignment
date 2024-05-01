variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the ALB and servers will be deployed"
  type        = list(string)
}

variable "alb_name" {
  description = "Name for the Application Load Balancer"
}

variable "alb_security_group_id" {
  description = "List of security group IDs for the Application Load Balancer"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name for the target group"
}

variable "target_group_port" {
  description = "Port for the target group"
  default     = 80
}

variable "target_group_protocol" {
  description = "Protocol for the target group"
  default     = "HTTP"
}

variable "server_security_group_name" {
  description = "Name for the security group for servers"
}

variable "server_instance_type" {
  description = "Instance type for the servers"
  default     = "t2.micro"
}

/*variable "server_ami" {
  description = "AMI ID for the servers"
}

variable "instance_ids" {
  description = "List of instance ids"
  type        = list(string)
}*/