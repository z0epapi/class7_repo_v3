resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-eip-for-nat"
  }

  depends_on = [aws_internet_gateway.igw] # This is an explicit dependency
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id # This is an implicit dependicy for eip
  subnet_id     = aws_subnet.public-sa-east-1a.id

  tags = {
    Name      = "Kalfu"
    Attribute = "Shadow"
    Domain    = "Night"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}