provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  tags = {
    Name    = "ranjan-tf-backend"
    Project = "ranjan"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "ranjan-tf-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "ranjan-tf-lock"
    Project = "ranjan"
  }
}
