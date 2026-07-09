variable "cluster_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "namespace" {
  type = string
}

variable "service_account" {
  type = string
}

variable "role_name" {
  type = string
}

variable "policy_arns" {
  type = list(string)
}

variable "permissions_boundary" {
  type    = string
  default = null
}

variable "path" {
  type    = string
  default = "/"
}

variable "max_session_duration" {
  type    = number
  default = 3600
}

variable "tags" {
  type = map(string)
}
