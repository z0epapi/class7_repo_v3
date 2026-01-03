# EIP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-eip-for-nat"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency 
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]

}

# Public NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
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