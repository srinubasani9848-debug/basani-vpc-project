terraform {
  backend "s3" {
    bucket         = "ranjan-terraform-backend-2025"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "ranjan-tf-lock"
    encrypt        = true
  }
}
