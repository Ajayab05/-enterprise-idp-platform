variable "project_name" {
  description = "Project name used for naming resources."
  type        = string

  validation {
    condition     = length(trim(var.project_name, " ")) > 0
    error_message = "Project name cannot be empty."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["lab", "dev", "qa", "uat", "prod"],
      var.environment
    )
    error_message = "Environment must be one of: lab, dev, qa, uat, or prod."
  }
}

variable "aws_region" {
  description = "AWS region for deployment."
  type        = string
  default     = "us-east-1"
}

variable "enable_key_rotation" {
  description = "Enable automatic KMS key rotation."
  type        = bool
  default     = true
}

variable "enable_bucket_versioning" {
  description = "Enable S3 bucket versioning."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow Terraform to delete a non-empty S3 bucket. Keep false for production."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}


variable "repository_name" {
  description = "Git repository name."
  type        = string
}

variable "owner" {
  description = "Platform owner."
  type        = string
}
