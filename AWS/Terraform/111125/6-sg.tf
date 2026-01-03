###############################
### Security Groups for ASG ###
###############################

###### Target Group Security Group ######
resource "aws_security_group" "asg-sg01-tg01" {
  name        = "asg-sg01-tg01"
  description = "Allow HTTP traffic for target group"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name          = "asg-sg01-tg01"
    Env           = "Test"
    Service       = "Security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-to-asg-sg01-tg01" {
  security_group_id = aws_security_group.asg-sg01-tg01.id
  cidr_ipv4         = aws_vpc.crossroads-vpc.cidr_block # Allow HTTP ingress from vpc (Can be 0.0.0.0/0 but not applicable or secure in real-world scenario)
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "egress-from-asg-sg01-tg01" {
  security_group_id = aws_security_group.asg-sg01-tg01.id
  cidr_ipv4         = "0.0.0.0/0" # Allow outbound traffic to all IPs
  ip_protocol       = "-1"        # semantically equivalent to all ports
}

###### Load Balancer Security Group ######
resource "aws_security_group" "asg-sg02-lb01" {
  name        = "asg-sg02-lb01"
  description = "Allow HTTP traffic for load balancer"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name          = "asg-sg02-lb01"
    Env           = "Test"
    Service       = "Security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-to-asg-sg02-lb01" {
  security_group_id = aws_security_group.asg-sg02-lb01.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow HTTP ingress from anywhere
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "egress-from-asg-sg02-tg01" {
  security_group_id = aws_security_group.asg-sg02-lb01.id
  cidr_ipv4         = "0.0.0.0/0" # Allow outbound traffic to all IPs
  ip_protocol       = "-1"        # semantically equivalent to all ports
}