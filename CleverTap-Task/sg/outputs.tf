# modules/sg/outputs.tf

output "ec2_security_group_id" {
  description = "The ID of the security group for EC2 instances."
  value       = aws_security_group.ec2_sg.id
}

output "rds_security_group_id" {
  description = "The ID of the security group for RDS instances."
  value       = aws_security_group.rds_sg.id
}

output "alb_security_group_id" {
  description = "The ID of the security group for RDS instances."
  value       = aws_security_group.alb_sg.id
}

output "ec2_security_group_name" {
  description = "The name of the security group for EC2 instances."
  value = aws_security_group.ec2_sg.name
}

