# EIP for NAT
resource "aws_eip" "crossroads-nat-eip" {
  domain = "vpc"

  tags = {
    Name = "crossroads-eip-for-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency 
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.crossroads-igw]

}

# Public NAT
resource "aws_nat_gateway" "crossroads-nat" {
  allocation_id = aws_eip.crossroads-nat-eip.id
  subnet_id     = aws_subnet.public-sa-east-1a.id

  tags = {
    Name      = "Kalfu"
    Attribute = "Shadow"
    Domain    = "Night"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.crossroads-igw]
}