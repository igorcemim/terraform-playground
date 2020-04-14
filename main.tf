provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

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

}

resource "aws_route" "igw" {
  route_table_id = aws_route_table.igw.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}

# NAT
resource "aws_route_table" "ngw" {
  vpc_id = aws_vpc.vcp_igor.id
}

resource "aws_route" "ngw" {
  route_table_id = aws_route_table.ngw.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.main.id
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

# Security
resource "aws_security_group" "security_group_ssh" {
    name = "servidor-ssh"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    vpc_id = aws_vpc.vcp_igor.id
}
resource "aws_security_group" "security_group_http" {
  name = "servidor-http"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vcp_igor.id
}
# Permite qualquer tráfego de saída
resource "aws_security_group" "security_group_exit_enable_all" {
  name = "exit-enable-all"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vcp_igor.id
}

# S3
resource "aws_s3_bucket" "igor_dev4_s3" {
  bucket = "igor-dev4-s3"
  acl    = "private"

  tags = {
    Name = "igor-dev4-s3"
  }
}

# EC2
resource "aws_instance" "igor_dev" {
    count = 3
    ami = "ami-07ebfd5b3428b6f4d" # Ubuntu Server 18.04 LTS
    instance_type = "t2.micro"
    key_name = "terraform-aws"
    subnet_id = aws_subnet.subnet_public_1a.id
    vpc_security_group_ids = [
      aws_security_group.security_group_ssh.id,
      aws_security_group.security_group_exit_enable_all.id
    ]
    associate_public_ip_address = true
        tags = {
        Name = "igor_dev${count.index}"
    }
}

resource "aws_instance" "igor_dev4" {
  ami = "ami-07ebfd5b3428b6f4d" # Ubuntu Server 18.04 LTS
  instance_type = "t2.micro"
  key_name = "terraform-aws"
  subnet_id = aws_subnet.subnet_public_1a.id
  vpc_security_group_ids = [
    aws_security_group.security_group_ssh.id,
    aws_security_group.security_group_exit_enable_all.id
  ]
  associate_public_ip_address = true
  tags = {
    Name = "igor_dev4"
  }
  depends_on = [aws_s3_bucket.igor_dev4_s3]
}

