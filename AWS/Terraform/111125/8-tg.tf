resource "aws_lb_target_group" "shadow-tg" {
  name            = "shadow-tg"
  target_type     = "instance"
  port            = 80
  protocol        = "HTTP"
  ip_address_type = "ipv4"
  vpc_id          = aws_vpc.crossroads-vpc.id

  tags = {
    Name          = "shadow-tg"
    Env           = "Test"
    Service       = "Auto Scaling"
  }
}