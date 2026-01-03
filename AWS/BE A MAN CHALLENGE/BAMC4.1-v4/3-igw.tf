# Allow ingress and egress traffic between VPC and Internet
resource "aws_internet_gateway" "bamc-igw" {
  vpc_id = aws_vpc.bamc-vpc.id # This is an implicit dependency

  tags = {
    Name        = "BAMC-igw"
    Environment = "Test"
    Serivce     = "Networking"
  }
}