resource "aws_s3_bucket" "igor_dev3_s3" {
  bucket = "igor-dev3-s3"
  acl    = "private"

  tags = {
    Name = "igor-dev3-s3"
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
