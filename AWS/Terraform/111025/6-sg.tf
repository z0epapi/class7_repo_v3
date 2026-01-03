##################################################
#### Security Groups For Stand-Alone Instance ####
##################################################

resource "aws_security_group" "shadow-sg" {
  name        = "shadow-sg01"     # This is the security group for the stand alone intance             
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.crossroads-vpc.id

  # This is an in-line argument that is no longer used by Terraform.name
  # This was used for demonstration purposes and should be commented out
  # ingress {
  #   from_port = 80
  #   to_port = 80
  #   protocol = "TCP"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "shadow-sg"
    Env     = "Test"
    Service = "Network"
  }
}

# This ingress rule all traffic ONLY from the VPC to access the homepage
# resource "aws_vpc_security_group_ingress_rule" "shadow-http" {
#   security_group_id = aws_security_group.shadow-sg.id
#   cidr_ipv4         = aws_vpc.crossroads-vpc.cidr_block   # I made a mistake by allowing only raffic from the VPC to access port 80
#   from_port         = 80                                  # It won't allow anywhere IPv4 
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# This ingress rule allows traffic from the internet to access the homepage
# resource "aws_vpc_security_group_ingress_rule" "all-http" { 
#   security_group_id = aws_security_group.shadow-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = 80
#   ip_protocol       = "tcp"
#   to_port           = 80
# }

# Allow Ingress traffic from HTTP
resource "aws_vpc_security_group_ingress_rule" "shadow-http-ingress" {
  security_group_id = aws_security_group.shadow-sg.id
  cidr_ipv4         = "0.0.0.0/0" # REMEMBER!!! This is means Anywhere IPv4 just like in the console
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Allow ingress traffic via SSH
resource "aws_vpc_security_group_ingress_rule" "shadow-ssh-ingress" {
  security_group_id = aws_security_group.shadow-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# Allow egress traffic to all IP addresses
resource "aws_vpc_security_group_egress_rule" "shadow-egress" {
  security_group_id = aws_security_group.shadow-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

###################
### SG for ping ###
###################

resource "aws_security_group" "ping" {
  name        = "ping"
  description = "Allow icmp for ping"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name = "icmp-for-ping"
    Env     = "Test"
    Service = "Network"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress-to-ping" {
  security_group_id = aws_security_group.ping.id
  cidr_ipv4         = aws_vpc.crossroads-vpc.cidr_block
  from_port         = -1
  ip_protocol       = "icmp"
  to_port           = -1
}

resource "aws_vpc_security_group_egress_rule" "egress-from-ping" {
  security_group_id = aws_security_group.ping.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
