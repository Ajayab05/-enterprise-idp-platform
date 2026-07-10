variable "domain_name" {
  description = "Public domain"
  type        = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}
