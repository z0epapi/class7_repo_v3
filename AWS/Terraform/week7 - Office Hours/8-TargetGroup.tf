resource "aws_lb_target_group" "office-hours-tg01" {
  name     = "office-hours-tg01"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.office-hours-vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "office-hours-tg01"
    Service = "App1"
    Owner   = "User"
    Project = "Web Service"
  }
}