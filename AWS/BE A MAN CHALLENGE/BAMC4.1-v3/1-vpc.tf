resource "aws_vpc" "bamc-vpc" {
  cidr_block           = "10.80.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name         = "BAMC-vpc"
    Envirionment = "Test"
    Service      = "Networking"
  }
}