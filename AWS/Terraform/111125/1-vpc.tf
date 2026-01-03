# this  makes  vpc.id which is aws_vpc.crossroads.id
resource "aws_vpc" "crossroads-vpc" {
  cidr_block           = "10.80.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name    = "Crossroads"
    Env     = "Test"
    Service = "Network"
  }
}