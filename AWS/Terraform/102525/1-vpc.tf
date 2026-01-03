# this  makes  vpc.id which is aws_vpc.crossroads.id
resource "aws_vpc" "crossroads" {
  cidr_block = "10.80.0.0/16"

  tags = {
    Name = "Crossroads"
    Env  = "Test"
  }
}