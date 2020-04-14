provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  version = "~> 2.0"
  region  = "us-east-2"
}

# S3
resource "aws_s3_bucket" "igor_dev4_s3" {
  bucket = "igor-dev4-s3"
  acl    = "private"

  tags = {
    Name = "igor-dev4-s3"
  }
}

resource "aws_s3_bucket" "test_s3_east2" {
  bucket = "test-s3-east2"
  acl    = "private"
  provider = aws.us-east-2

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

