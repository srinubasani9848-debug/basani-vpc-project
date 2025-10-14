terraform {
  backend "s3" {
    bucket         = "srinivas-terraform-backend-2025"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "srinivas-tf-lock"
    encrypt        = true
  }
}

