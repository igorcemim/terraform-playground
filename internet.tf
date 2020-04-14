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
