resource "aws_subnet" "subnet_public_1a" {
  vpc_id = aws_vpc.vcp_igor.id
  cidr_block = "10.0.100.0/24"
}

resource "aws_route_table_association" "subnet_public_1a" {
  subnet_id = aws_subnet.subnet_public_1a.id
  route_table_id = aws_route_table.igw.id
}
