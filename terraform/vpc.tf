resource "aws_vpc" "fintech_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "fintech-production-vpc"
    Environment = "production"
    Compliance  = "GDPR"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.fintech_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"

  tags = {
    Name = "fintech-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.fintech_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "fintech-private-subnet-db"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.fintech_vpc.id
}
