###############################
### Security Groups for ASG ###
###############################

###### Target Group Security Group ######
resource "aws_security_group" "asg-tg-sg01" {
  name        = "asg-tg-sg01"
  description = "Allow HTTP traffic for target group"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name          = "asg-tg-sg01"
    Env           = "Test"
    Service       = "Security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-to-asg-tg-sg01" {
  security_group_id = aws_security_group.asg-tg-sg01.id
  cidr_ipv4         = aws_vpc.crossroads-vpc.cidr_block # Allow HTTP ingress from vpc (Can be 0.0.0.0/0 but not applicable or secure in real-world scenario)
  from_port         = 80                                # Makes certain that traffic is only flowing from VPC (i.e. Load Balancer)
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "egress-from-asg-tg-sg01" {
  security_group_id = aws_security_group.asg-tg-sg01.id
  cidr_ipv4         = "0.0.0.0/0" # Allow outbound traffic to all IPs
  ip_protocol       = "-1"        # semantically equivalent to all ports
}

###### Load Balancer Security Group ######
resource "aws_security_group" "asg-lb-sg02" {
  name        = "asg-lb-sg02"
  description = "Allow HTTP traffic for load balancer"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name          = "asg-lb-sg02"
    Env           = "Test"
    Service       = "Security"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-to-asg-lb-sg02" {
  security_group_id = aws_security_group.asg-lb-sg02.id
  cidr_ipv4         = "0.0.0.0/0" # Allow HTTP ingress from anywhere
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "egress-from-asg-lb-sg02" {
  security_group_id = aws_security_group.asg-lb-sg02.id
  cidr_ipv4         = "0.0.0.0/0" # Allow outbound traffic to all IPs
  ip_protocol       = "-1"        # semantically equivalent to all ports
}