resource "aws_instance" "igor_dev" {
  count = 2
  ami = var.amis.us-east-1-ubuntu-server
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
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

resource "aws_instance" "igor_dev2" {
  ami = var.amis.us-east-1-ubuntu-server
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair_us_east_2.key_name
  subnet_id = aws_subnet.subnet_public_1a.id
  vpc_security_group_ids = [
    aws_security_group.security_group_ssh.id,
    aws_security_group.security_group_exit_enable_all.id
  ]
  associate_public_ip_address = true
  tags = {
    Name = "igor_dev2"
  }
  depends_on = [aws_s3_bucket.igor_dev2_bucket]

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_dns
    private_key = file(var.ssh_private_key)
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello :D' > /tmp/hello.txt"
    ]
  }
}
