variable "amis" {
  type = map(string)
  default = {
    "us-east-1-ubuntu-server" = "ami-07ebfd5b3428b6f4d"
  }
}

variable "key_name" {
  default = "terraform-aws"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ssh_private_key" {
  default = "~/.ssh/terraform_aws_rsa"
}

variable "ssh_public_key" {
  default = "~/.ssh/terraform_aws_rsa.pub"
}

variable "ssh_private_key_content" {
  default = ""
}

variable "ssh_public_key_content" {
  default = ""
}
