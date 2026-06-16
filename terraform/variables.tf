variable "aws_region" {
  description = "AWS region for UK deployment"
  default     = "eu-west-2" # London Region
}

variable "db_password" {
  description = "Password for the RDS database (In production, use Secrets Manager)"
  type        = string
  default     = "SuperSecurePassword123!"
  sensitive   = true
}
