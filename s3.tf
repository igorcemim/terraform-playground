resource "aws_s3_bucket" "igor_dev2_bucket" {
  bucket = "igor-dev2-bucket"
  acl    = "private"

  tags = {
    Name = "igor-dev2-bucket"
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
