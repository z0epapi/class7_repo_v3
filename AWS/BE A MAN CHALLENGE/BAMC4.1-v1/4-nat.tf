# Provision an EIP for the NAT gateway
resource "aws_eip" "la-croix" {
  domain = "vpc"

  tags = {
    Name        = "La Croix"
    Environment = "Test"
    Service     = "Networking"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency 
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.legba]
}

# Public NAT
# NAT gate way is internet facing -- allows ONLY egress traffic from resources in the private subnets to the internet
resource "aws_nat_gateway" "kalfou" {
  allocation_id     = aws_eip.la-croix.id # Reference EIP to access internet -- also an implicit dependency
  connectivity_type = "public"
  # subnet_id         = aws_subnet.public-1a.id # Only apply when 'availability_mode' is set to 'zonal'
  availability_mode = "regional" # Argument is needed to make the NAT regionally resilient -- best for terraform version = "> 6.26.0"
  vpc_id            = aws_vpc.anansi.id

  tags = {
    Name        = "Kalfou"
    Environment = "Test"
    Service     = "Networking"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.legba]
}
