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
  public_key = fileexists(var.ssh_public_key) ? file(var.ssh_public_key) : var.ssh_public_key_content
}

resource "aws_key_pair" "key_pair_us_east_2" {
  key_name   = var.key_name
  public_key = fileexists(var.ssh_public_key) ? file(var.ssh_public_key) : var.ssh_public_key_content
  provider = aws.us-east-2
}
