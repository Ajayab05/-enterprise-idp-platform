variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  type        = string
}

variable "cluster_security_group_id" {
  description = "Cluster Security Group"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC Issuer URL"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private Application Subnets"
  type        = list(string)
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "tags" {
  description = "Common Tags"
  type        = map(string)
}
