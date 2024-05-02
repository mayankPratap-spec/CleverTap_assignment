# This file contains the output definitions for SSL/TLS Setup

output "certificate_arn" {
  description = "The ARN of the ACM Certificate"
  value       = aws_acm_certificate.wordpress_certificate.arn
}
