# Allow ingress and egress traffic between VPC and Internet
resource "aws_internet_gateway" "legba" {
  vpc_id = aws_vpc.anansi.id # This is an implicit dependency

  tags = {
    Name        = "Legba"
    Environment = "Test"
    Serivce     = "Networking"
  }
}