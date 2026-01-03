resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.office-hours-vpc.id

  tags = {
    Name    = "officaws_vpc.office-hours-vpc_IG"
    Service = "Internet Gateway"
    Owner   = "Luke"
    Planet  = "Musafar"
  }
}