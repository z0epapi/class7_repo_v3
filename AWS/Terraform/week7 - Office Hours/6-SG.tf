resource "aws_security_group" "office-hours-sg01" {
  name        = "office-hours-sg01"
  description = "Allow port 22 and port 80"
  vpc_id      = aws_vpc.office-hours-vpc.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["137.52.180.165/32"]
  }

#   ingress {
#     description = "MyEvilBox"
#     from_port   = 3389
#     to_port     = 3389
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["137.52.180.165/32"]
  }

  tags = {
    Name    = "office-hours-sg01"
    Service = "Instance"
    Owner   = "Luke"
    Planet  = "Musafar"
  }

}



resource "aws_security_group" "office-hours-sg02-LB01" {
  name        = "office-hours-sg02-LB01"
  description = "office-hours-sg02-LB01"
  vpc_id      = aws_vpc.office-hours-vpc.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "office-hours-sg02-LB01"
    Service = "Load Balancing"
    Owner   = "Luke"
    Planet  = "Musafar"
  }

}