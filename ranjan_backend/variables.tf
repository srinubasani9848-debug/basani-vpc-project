variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "S3 bucket for Terraform backend"
  type        = string
  default     = "ranjan-terraform-backend-2025"
}
