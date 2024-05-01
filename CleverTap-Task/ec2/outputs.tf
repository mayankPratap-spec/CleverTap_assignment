output "instance_ids" {
  value = aws_instance.ec2_instances[*].id
}

output "public_ip_addresses" {
  value = aws_instance.ec2_instances[*].public_ip
}

output "private_ip_addresses" {
  value = aws_instance.ec2_instances[*].private_ip
}

output "ami_id" {
   value       = [for instance in aws_instance.ec2_instances : instance.ami]
}
