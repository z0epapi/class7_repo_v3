resource "aws_lb" "office-hours-alb" {
  name               = "office-hours-alb"
  internal           = false # Becuase it is public facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.office-hours-sg02-LB01.id]
  subnets            = [
    aws_subnet.public-eu-west-1a.id,
    aws_subnet.public-eu-west-1b.id,
    aws_subnet.public-eu-west-1c.id
  ]
  enable_deletion_protection = false
#Lots of death and suffering here, make sure it's false (It will self-heal becuase of the load balacer)

  tags = {
    Name    = "office-hours-alb"
    Service = "Load Balancing"
    Owner   = "User"
    Project = "demo for Office Hours"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.office-hours-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.office-hours-tg01.arn
  }
}

## For Route 53 and HTTPS
# data "aws_acm_certificate" "cert" {
#   domain   = "balerica-aisecops.com"
#   statuses = ["ISSUED"]
#   most_recent = true
# }


# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.app1_alb.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"  # or whichever policy suits your requirements
#   certificate_arn   = data.aws_acm_certificate.cert.arn



#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app1_tg.arn
#   }
# }

# output "lb_dns_name" {
#   value       = aws_lb.app1_alb.dns_name
#   description = "The DNS name of the App1 Load Balancer."
# }