################## Public Route Table ##################
### Controls routing for public subnets ###
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.anansi.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.legba.id
  }

  tags = {
    Name    = "Public Route Table"
    Env     = "Test"
    Service = "Network"
  }
}


### Route Table Association for Public Subnets in each AZ ###
## Provisions resource to associate the route table and the public subnets ##
resource "aws_route_table_association" "pub-rtb-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "pub-rtb-1b" {
  subnet_id      = aws_subnet.public-1b.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "pub-rtb-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public-rtb.id
}


################## Private Route Table ##################
### Controls routing for private subnets ###
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.anansi.id

  route {
    cidr_block = "0.0.0.0/0" # To make sure only VPC traffic is allowed -- ask Joseph why aws_vpc.anansi.cidr_block
    gateway_id = aws_nat_gateway.kalfou.id
  }

  tags = {
    Name    = "Private Route Table"
    Env     = "Test"
    Service = "Network"
  }
}

### Route Table Association for Private Subnets in each AZ ###
## Provisions resource to associate the route table and the private subnets ##
resource "aws_route_table_association" "prt-rtb-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "prt-rtb-1b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "prt-rtb-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.private-rtb.id
}