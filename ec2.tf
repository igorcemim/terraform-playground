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

resource "aws_instance" "igor_dev3" {
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
    Name = "igor_dev3"
  }
  depends_on = [aws_s3_bucket.igor_dev3_s3]
}
