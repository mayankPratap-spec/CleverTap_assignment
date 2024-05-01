# Auto Scaling Group
resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity         = var.asg_desired_capacity
  min_size                 = var.asg_min_size
  max_size                 = var.asg_max_size
  vpc_zone_identifier      = var.public_subnet_ids
  launch_configuration     = aws_launch_configuration.wordpress_lc.name
  #target_group_arns        = [ "var.target_group_arns" ]
  target_group_arns         =  var.target_group_arns

  tag {
    key                 = "Name"
    value               = "wordPress-asg"
    propagate_at_launch = true
  }
}

# Launch Configuration
resource "aws_launch_configuration" "wordpress_lc" {
  name_prefix   = "wordpress-"
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name
  security_groups = var.security_group_ids
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}

# Scaling Policy
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale_out_on_high_cpu_utilization"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 20 # Adjust the target CPU utilization percentage as needed
  }
}
