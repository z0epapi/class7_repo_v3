resource "aws_internet_gateway" "crossroads-igw" {
  vpc_id = aws_vpc.crossroads-vpc.id # This is an implicit dependency

  tags = {
    Name      = "Legba"
    Attribute = "Light"
    Domain    = "Day"
  }
}