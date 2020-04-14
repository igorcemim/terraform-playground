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
