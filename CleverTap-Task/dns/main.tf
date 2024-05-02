# This file contains the main Terraform configuration for DNS Configuration

resource "aws_route53_zone" "wordpress_zone" {
  name = var.domain_name
}

resource "aws_route53_record" "elb_dns_record" {
  zone_id = aws_route53_zone.wordpress_zone.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.elb_dns_name
    zone_id                = var.elb_dns_zone_id
    evaluate_target_health = true
  }
}
