# This file contains the output definitions for DNS Configuration

output "elb_dns_record_name" {
  description = "The name of the DNS record pointing to the ELB"
  value       = aws_route53_record.elb_dns_record.name
}

output "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = aws_route53_zone.wordpress_zone.zone_id
}
