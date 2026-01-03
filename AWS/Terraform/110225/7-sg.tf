# For webserver only
resource "aws_security_group" "server-sg" {
  name        = "server-sg"
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
    Name = "server-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "server-http" {
  security_group_id = aws_security_group.server-sg.id
  cidr_ipv4         = aws_vpc.crossroads-vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "all-http" {
  security_group_id = aws_security_group.server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "server-ssh" {
  security_group_id = aws_security_group.server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.server-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

### SG for ping ###

resource "aws_security_group" "ping" {
  name        = "ping"
  description = "Allow icmp for ping"
  vpc_id      = aws_vpc.crossroads-vpc.id

  tags = {
    Name = "icmp-for-ping"
  }
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
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
