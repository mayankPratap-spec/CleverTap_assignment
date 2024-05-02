# This file contains the main Terraform configuration for SSL/TLS Setup

resource "aws_acm_certificate" "wordpress_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "wordpress-certificate"
  }
}

# Wait for ACM certificate to be issued
resource "aws_acm_certificate_validation" "wordpress_certificate_validation" {
  certificate_arn = aws_acm_certificate.wordpress_certificate.arn
}

locals {
  certificate_domain_validation_options = [
    for option in aws_acm_certificate.wordpress_certificate.domain_validation_options : {
      name    = option.resource_record_name
      type    = option.resource_record_type
      value   = option.resource_record_value
    }
  ]
}

# Create Route 53 records for certificate validation
resource "aws_route53_record" "certificate_validation" {
  count = length(local.certificate_domain_validation_options)

  zone_id = var.route53_zone_id
  name    = local.certificate_domain_validation_options[count.index].name
  type    = local.certificate_domain_validation_options[count.index].type
  ttl     = 300
  records = [local.certificate_domain_validation_options[count.index].value]
}
