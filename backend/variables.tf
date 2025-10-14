variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "S3 bucket for Terraform backend"
  type        = string
  default     = "basani-terraform-backend-2025"
}
