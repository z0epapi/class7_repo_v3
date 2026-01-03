resource "aws_lb" "shadow-alb" {
  name               = "shadow-alb"
  internal           = false # Internal must be set to false to be internet facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg-sg02-lb01.id]
  ip_address_type    = "ipv4"
  subnets = [
    aws_subnet.public-sa-east-1a.id,
    aws_subnet.public-sa-east-1b.id,
  aws_subnet.public-sa-east-1c.id] # Load balancer must be in the public subnets to be internet facing

  enable_deletion_protection = false # Make sure it is set to false to ease teardowns

  tags = {
    Name          = "shadow-alb"
    Environment   = "Test"
    Service       = "Load Balancing"
  }
}

resource "aws_lb_listener" "shadow-alb-listener" {
  load_balancer_arn = aws_lb.shadow-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shadow-tg.arn
  }
}