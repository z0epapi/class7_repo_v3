############## Public Subnets #################
resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.anansi.id
  cidr_block              = "10.80.1.0/24"
  availability_zone       = "af-south-1a"
  map_public_ip_on_launch = true # Must be set to true for subnets to have public IP

  tags = {
    Name        = "Public Subnet 1a"
    Environment = "Test"
    Service     = "Networking"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id                  = aws_vpc.anansi.id
  cidr_block              = "10.80.2.0/24"
  availability_zone       = "af-south-1b"
  map_public_ip_on_launch = true # Must be set to true for subnets to have public IP

  tags = {
    Name        = "Public Subnet 1b"
    Environment = "Test"
    Service     = "Networking"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id                  = aws_vpc.anansi.id
  cidr_block              = "10.80.3.0/24"
  availability_zone       = "af-south-1c"
  map_public_ip_on_launch = true # Must be set to true for subnets to have public IP

  tags = {
    Name        = "Public Subnet 1c"
    Environment = "Test"
    Service     = "Networking"
  }
}


############## Private Subnets #################
resource "aws_subnet" "private-1a" {
  vpc_id            = aws_vpc.anansi.id
  cidr_block        = "10.80.11.0/24"
  availability_zone = "af-south-1a"

  tags = {
    Name        = "Private Subnet 1a"
    Environment = "Test"
    Service     = "Netwoking"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id            = aws_vpc.anansi.id
  cidr_block        = "10.80.12.0/24"
  availability_zone = "af-south-1b"

  tags = {
    Name        = "Private Subnet 1b"
    Environment = "Test"
    Service     = "Netwoking"
  }
}

resource "aws_subnet" "private-1c" {
  vpc_id            = aws_vpc.anansi.id
  cidr_block        = "10.80.13.0/24"
  availability_zone = "af-south-1c"

  tags = {
    Name        = "Private Subnet 1c"
    Environment = "Test"
    Service     = "Netwoking"
  }
}