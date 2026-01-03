############## Public Subnets #################

resource "aws_subnet" "public-sa-east-1a" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.1.0/24"
  availability_zone = "sa-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public Road 1a"
    Env     = "Test"
    Service = "Network"
  }
}

resource "aws_subnet" "public-sa-east-1b" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.2.0/24"
  availability_zone = "sa-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public Road 1b"
    Env     = "Test"
    Service = "Network"
  }
}

resource "aws_subnet" "public-sa-east-1c" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.3.0/24"
  availability_zone = "sa-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "Public Road 1c"
    Env     = "Test"
    Service = "Network"
  }
}


############## Private Subnets #################

resource "aws_subnet" "private-sa-east-1a" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.11.0/24"
  availability_zone = "sa-east-1a"

  tags = {
    Name    = "Private Road 1a"
    Env     = "Test"
    Service = "Netowrk"
  }
}

resource "aws_subnet" "private-sa-east-1b" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.12.0/24"
  availability_zone = "sa-east-1b"

  tags = {
    Name    = "Private Road 1b"
    Env     = "Test"
    Service = "Netowrk"
  }
}

resource "aws_subnet" "private-sa-east-1c" {
  vpc_id            = aws_vpc.crossroads.id
  cidr_block        = "10.80.13.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name    = "Private Road 1c"
    Env     = "Test"
    Service = "Netowrk"
  }
}