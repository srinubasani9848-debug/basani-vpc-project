terraform {
  backend "s3" {
    bucket         = "basani-terraform-backend-2025"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "basani-tf-lock"
    encrypt        = true
  }
}
