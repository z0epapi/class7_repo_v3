# this  makes  vpc.id which is aws_vpc.hungry-wolves-app.id
resource "aws_vpc" "hungry-wolves-app" {
  cidr_block = "10.80.0.0/16"

  tags = {
    Name    = "hungry-wolves-app"
    Service = "application1"
    Owner   = "Chewbacca"
    Planet  = "Mustafar"
  }
}
