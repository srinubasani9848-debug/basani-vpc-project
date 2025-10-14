provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "tf_state" {
  bucket = var.bucket_name
  tags = {
    Name    = "basani-tf-backend"
    Project = "basani"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "basani-tf-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = "basani-tf-lock"
    Project = "basani"
  }
}
