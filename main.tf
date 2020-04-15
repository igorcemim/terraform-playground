provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  version = "~> 2.0"
  region  = "us-east-2"
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = file(var.ssh_public_key)
}

resource "aws_key_pair" "key_pair_us_east_2" {
  key_name   = var.key_name
  public_key = file(var.ssh_public_key)
  provider = aws.us-east-2
}
