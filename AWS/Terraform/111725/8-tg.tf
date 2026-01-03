resource "aws_lb_target_group" "shadow-tg" {
  name            = "shadow-tg"
  target_type     = "instance"
  port            = 80
  protocol        = "HTTP"
  ip_address_type = "ipv4"
  vpc_id          = aws_vpc.crossroads-vpc.id

  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 30
    matcher = 200
    path = "/"
    timeout = 6
    unhealthy_threshold = 3

  }

  tags = {
    Name          = "shadow-tg"
    Env           = "Test"
    Service       = "Auto Scaling"
  }
}