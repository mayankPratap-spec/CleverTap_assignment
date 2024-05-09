# Create security group for ALB
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_security_group_name
  vpc_id      = var.vpc_id

  // Allow SSH access from anywhere for demonstration purposes
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  // Allow HTTP access from anywhere for demonstration purposes
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
/*
resource "aws_security_group" "rds_sg" {
  name        = var.rds_security_group_name
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  // Allow MySQL/Aurora access from EC2 instances in the same security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }
}*/

resource "aws_security_group" "rds_sg" {
  name        = var.rds_security_group_name
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  // Allow MySQL/Aurora access from EC2 instances in the same security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  // Allow traffic from your IP address
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["49.43.0.169/32"]  # Replace YOUR_IP_ADDRESS with your actual IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

}


