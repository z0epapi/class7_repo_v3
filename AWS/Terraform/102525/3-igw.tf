resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.crossroads.id # This is an implicit dependency

  tags = {
    Name      = "Legba"
    Attribute = "Light"
    Domain    = "Day"
  }
}