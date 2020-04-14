resource "aws_vpc" "vcp_igor" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vcp_igor_1"
  }
}

# Internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vcp_igor.id
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.vcp_igor.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# NAT
resource "aws_route_table" "ngw" {
  vpc_id = aws_vpc.vcp_igor.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.subnet_public_1a.id
}

# Subnet
resource "aws_subnet" "subnet_public_1a" {
  vpc_id = aws_vpc.vcp_igor.id
  cidr_block = "10.0.100.0/24"
}

resource "aws_route_table_association" "subnet_public_1a" {
  subnet_id = aws_subnet.subnet_public_1a.id
  route_table_id = aws_route_table.igw.id
}
