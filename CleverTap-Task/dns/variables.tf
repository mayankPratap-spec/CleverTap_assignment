# This file contains the variable definitions for DNS Configuration

variable "domain_name" {
  description = "The domain name to manage with Route 53"
  type        = string
}

variable "elb_dns_name" {
  description = "The DNS name of the Elastic Load Balancer"
  type        = string
}

variable "elb_dns_zone_id" {
  description = "The zone ID of the Elastic Load Balancer"
  type        = string
}
