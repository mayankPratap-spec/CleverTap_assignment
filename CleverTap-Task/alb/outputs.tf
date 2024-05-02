output "target_group_arns" {
  value = aws_lb_target_group.target_group.arn
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "alb_dns_zone_id" {
  value = aws_lb.alb.zone_id
}