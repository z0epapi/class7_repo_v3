# resource "aws_security_group" "crossroads-sg" {
#   name        = "Ogoun"
#   description = "Allow SSH and HTTP access"
#   vpc_id      = aws_vpc.crossroads.id

#   ingress {
#     description = "MyHomePage"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "SSH"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#     egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "Ogoun"
#   }
# }

resource "aws_security_group" "gad-sg" {
  name        = "gad-sg"
  description = "Allow inbound and outbound traffic"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name = "Gad"
  }
}

resource "aws_vpc_security_group_ingress_rule" "gad-sg-ssh" {
  security_group_id = aws_security_group.gad-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow SSH traffic from anywhere"

  tags = {
    Name = "SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "gad-sg-http" {
  security_group_id = aws_security_group.gad-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  description       = "Allow HTTP traffic from anywhere"

  tags = {
    Name = "HTTP"
  }
}

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

resource "aws_vpc_security_group_egress_rule" "gad-sg-egress" {
  security_group_id = aws_security_group.gad-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  description       = "Allow egress traffic for all IPs"
}

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv6         = "::/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

# resource "aws_security_group" "example" {
#   # ... other configuration ...

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }