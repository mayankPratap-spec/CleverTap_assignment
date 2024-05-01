output "asg_name" {
  value = aws_autoscaling_group.wordpress_asg.name
}

output "asg_desired_capacity" {
  value = aws_autoscaling_group.wordpress_asg.desired_capacity
}

output "asg_min_size" {
  value = aws_autoscaling_group.wordpress_asg.min_size
}

output "asg_max_size" {
  value = aws_autoscaling_group.wordpress_asg.max_size
}

output "asg_launch_configuration_name" {
  value = aws_launch_configuration.wordpress_lc.name
}
