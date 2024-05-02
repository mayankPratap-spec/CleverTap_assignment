

# Create Application Load Balancer
resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_id
  subnets            = var.subnet_ids
}

# Create target group
resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = var.target_group_port
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
}

# Attach servers to target group
/*resource "aws_lb_target_group_attachment" "servers_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.server_instance_ids[0]
}

resource "aws_lb_target_group_attachment" "servers_attachment_2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.server_instance_ids[1]
}

resource "aws_lb_target_group_attachment" "servers_attachment_3" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.server_instance_ids[2]
}


resource "aws_lb_target_group_attachment" "servers_attachment" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_ids[count.index]
}*/

# Create ALB listener
/*resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}*/

# Create ALB listener for HTTPS traffic
resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"

  #ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
