################## Public Route Table ##################
resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.crossroads.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

### Route Table Association for Public Subnets in each AZ ###
resource "aws_route_table_association" "public-rtb-1a" {
  subnet_id      = aws_subnet.public-sa-east-1a.id
  route_table_id = aws_route_table.public-rtb.id
}

### Route Table Association for Public Subnets in each AZ ###
resource "aws_route_table_association" "public-rtb-1b" {
  subnet_id      = aws_subnet.public-sa-east-1b.id
  route_table_id = aws_route_table.public-rtb.id
}

### Route Table Association for Public Subnets in each AZ ###
resource "aws_route_table_association" "public-rtb-1c" {
  subnet_id      = aws_subnet.public-sa-east-1c.id
  route_table_id = aws_route_table.public-rtb.id
}

################## Private Route Table ##################
resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.crossroads.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

### Route Table Association for Private Subnets in each AZ ###
resource "aws_route_table_association" "private-rtb-1a" {
  subnet_id      = aws_subnet.private-sa-east-1a.id
  route_table_id = aws_route_table.private-rtb.id
}

### Route Table Association for Private Subnets in each AZ ###
resource "aws_route_table_association" "private-rtb-1b" {
  subnet_id      = aws_subnet.private-sa-east-1b.id
  route_table_id = aws_route_table.private-rtb.id
}

### Route Table Association for Private Subnets in each AZ ###
resource "aws_route_table_association" "private-rtb-1c" {
  subnet_id      = aws_subnet.private-sa-east-1c.id
  route_table_id = aws_route_table.private-rtb.id
}