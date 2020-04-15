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
