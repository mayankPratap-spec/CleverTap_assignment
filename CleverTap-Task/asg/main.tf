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

/*
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
}*/

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

user_data = <<-EOF
              #!/bin/bash

              # Connect to RDS instance and create WordPress database
              mysql -h ${split(":", var.rds_endpoint)[0]} -u "admin" -p${var.db_password} -e 'CREATE DATABASE IF NOT EXISTS wordpress;'
            EOF
}

/*
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

  user_data = <<-EOF
    #!/bin/bash

    # Define the path to your local file
    LOCAL_FILE="E:\\CleverTap-Task\\wp-config.php"


    # Define the new hostname
    NEW_HOSTNAME="$${new_hostname}"

    # Use sed to replace the hostname in the file
    sed -i "s/old_hostname/$NEW_HOSTNAME/g" "$LOCAL_FILE"


    # Define the path to the new wp-config.php file on your local server
    NEW_WP_CONFIG_FILE="E:\\CleverTap-Task\\wp-config.php"

    # Copy the new wp-config.php file to the temporary directory
    cp "$NEW_WP_CONFIG_FILE" /tmp/wp-config.php

    # Replace the existing wp-config.php file with the new one
    mv /tmp/wp-config.php stack/wordpress/wp-config.php
  EOF
}*/

/*
# Launch Configuration
resource "aws_launch_configuration" "wordpress_lc" {
  name_prefix   = "wordpress-"
  image_id      = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name
  security_groups = var.security_group_ids
  associate_public_ip_address = true
  user_data     = <<-EOF
    #!/bin/bash

    # Update wp-config.php with RDS database details
    sed -i "s/define('DB_NAME', 'database_name');/define('DB_NAME', '${var.db_name}');/" stack/wordpress/wp-config.php
    sed -i "s/define('DB_USER', 'database_user');/define('DB_USER', '${var.db_user}');/" stack/wordpress/wp-config.php
    sed -i "s/define('DB_PASSWORD', 'database_password');/define('DB_PASSWORD', '${var.db_password}');/" stack/wordpress/wp-config.php
    sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', '${var.db_host}');/" stack/wordpress/wp-config.php

    # Set executable permissions for wp-config.php
    chmod +x stack/wordpress/wp-config.php
    EOF

  lifecycle {
    create_before_destroy = true
  }
}*/


# Scaling Policy
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale_out_on_high_cpu_utilization"
  policy_type            = "TargetTrackingScaling"
  estimated_instance_warmup = 300
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 20 # Adjust the target CPU utilization percentage as needed
  }

  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
}
