################# Publib Route Table ##################

resource "aws_route_table" "public-rtb" {
  vpc_id = aws_vpc.crossroads.id

  # Default gateway route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rtb"
  }
}

resource "aws_route_table_association" "public-sa-east-1a" {
  subnet_id      = aws_subnet.public-sa-east-1a.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-sa-east-1b" {
  subnet_id      = aws_subnet.public-sa-east-1b.id
  route_table_id = aws_route_table.public-rtb.id
}

resource "aws_route_table_association" "public-sa-east-1c" {
  subnet_id      = aws_subnet.public-sa-east-1c.id
  route_table_id = aws_route_table.public-rtb.id
}


############## Private Route Table #################

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.crossroads.id

  # Default gateway route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private-rtb"
  }
}

resource "aws_route_table_association" "private-sa-east-1a" {
  subnet_id      = aws_subnet.private-sa-east-1a.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-sa-east-1b" {
  subnet_id      = aws_subnet.private-sa-east-1b.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "private-sa-east-1c" {
  subnet_id      = aws_subnet.private-sa-east-1c.id
  route_table_id = aws_route_table.private-rtb.id
}