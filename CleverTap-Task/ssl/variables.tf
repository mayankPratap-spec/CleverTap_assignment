# This file contains the variable definitions for SSL/TLS Setup

variable "domain_name" {
  description = "The domain name for which to provision the ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone where DNS records will be created for certificate validation"
  type        = string
}