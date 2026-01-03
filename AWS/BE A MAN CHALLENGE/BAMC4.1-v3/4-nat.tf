# Provision an EIP for the NAT gateway
resource "aws_eip" "bamc-eip" {
  domain = "vpc"

  tags = {
    Name        = "bemc-eip"
    Environment = "Test"
    Service     = "Networking"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency 
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.bamc-igw]
}

# Public NAT
# NAT gate way is internet facing -- allows ONLY egress traffic from resources in the private subnets to the internet
resource "aws_nat_gateway" "bamc-nat" {
  allocation_id     = aws_eip.bamc-eip.id # Reference EIP to access internet -- also an implicit dependency
  connectivity_type = "public"            # Must be public if 'availability_mode' is regional
  # subnet_id         = aws_subnet.public-1a.id # Only apply when 'availability_mode' is set to 'zonal'
  availability_mode = "regional" # Argument is needed to make the NAT regionally resilient -- best for terraform version = "> 6.26.0"
  vpc_id            = aws_vpc.bamc-vpc.id

  tags = {
    Name        = "bamc-nat"
    Environment = "Test"
    Service     = "Networking"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.bamc-igw]
}
