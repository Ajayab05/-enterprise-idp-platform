variable "namespace" {
  type    = string
  default = "kube-system"
}

variable "chart_version" {
  type    = string
  default = "3.13.0"
}

variable "tags" {
  type    = map(string)
  default = {}
}
