#############################################
#### Security Group For Bastion Jump Box ####
#############################################

resource "aws_security_group" "bastion-sg01" {
  name        = "bastion-sg01"
  description = "Allow all inbound SSH and outbound SSH to Backend"
  vpc_id      = aws_vpc.anansi.id

  tags = {
    Name    = "bastion-sg01"
    Env     = "Test"
    Service = "Network"
  }
}

# Allow ingress traffic via RDP
resource "aws_vpc_security_group_ingress_rule" "bastion-rdp-ingress" {
  security_group_id = aws_security_group.bastion-sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389

  tags = {
    Name = "Allow RDP from anywhere"
  }
}

# Allow Outbound Traffic to Backend Server
resource "aws_vpc_security_group_egress_rule" "bastion-egress" {
  security_group_id            = aws_security_group.bastion-sg01.id
  referenced_security_group_id = aws_security_group.backend-sg02.id
  # from_port                    = 22
  ip_protocol                  = "-1" # semantically equivalent to all ports
  # to_port                      = 22

  tags = {
    Name = "Allow traffic to Backend Server"
  }
}


# Allow egress traffic to all IP addresses
# resource "aws_vpc_security_group_egress_rule" "bastion-egress" {
#   security_group_id = aws_security_group.bastion-sg01.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports

#   tags = {
#     Name = "Allow outbound traffic to all IPs"
#   }
# }

#############################################
#### Security Group For Backend Instance ####
#############################################

resource "aws_security_group" "backend-sg02" {
  name        = "backend-sg02"
  description = "Allow all inbound SSH and outbound SSH to Backend"
  vpc_id      = aws_vpc.anansi.id

  tags = {
    Name    = "backend-sg02"
    Env     = "Test"
    Service = "Network"
  }
}

# Allow ingress traffic from Bastion SG
resource "aws_vpc_security_group_ingress_rule" "ssh-to-backend" {
  security_group_id            = aws_security_group.backend-sg02.id
  referenced_security_group_id = aws_security_group.bastion-sg01.id
  # from_port                    = 22
  ip_protocol                  = "-1"
  # to_port                      = 22

  tags = {
    Name = "Allow SSH from Bastion"
  }
}

# Allow egress traffic to all IP addresses
resource "aws_vpc_security_group_egress_rule" "egress-from-backend" {
  security_group_id = aws_security_group.bastion-sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  tags = {
    Name = "Allow outbound traffic to all IPs"
  }
}

###################
### SG for ping ###
###################

# resource "aws_security_group" "ping" {
#   name        = "ping"
#   description = "Allow icmp for ping"
#   vpc_id      = aws_vpc.anansi.id

#   tags = {
#     Name    = "icmp-for-ping"
#     Env     = "Test"
#     Service = "Network"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "ingress-to-ping" {
#   security_group_id = aws_security_group.ping.id
#   cidr_ipv4         = aws_vpc.anansi.cidr_block
#   from_port         = -1
#   ip_protocol       = "icmp"
#   to_port           = -1
# }

# resource "aws_vpc_security_group_egress_rule" "egress-from-ping" {
#   security_group_id = aws_security_group.ping.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports

#   tags = {
#     Name = "Allow ping"
#   }
# }
