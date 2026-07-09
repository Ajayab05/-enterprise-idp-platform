###############################################
# General
###############################################

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "owner" {
  type = string
}

###############################################
# Networking
###############################################

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

###############################################
# Cluster
###############################################

variable "cluster_name" {
  type    = string
  default = "eks"
}

variable "cluster_version" {
  type    = string
  default = "1.33"
}

###############################################
# Tags
###############################################

variable "tags" {
  type    = map(string)
  default = {}
}


variable "cluster_public_access_cidrs" {
  description = "CIDR blocks allowed to access the EKS public endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}





###############################################
# Endpoint Access
###############################################

variable "cluster_public_access" {

  type = bool

  default = true

}

variable "cluster_private_access" {

  type = bool

  default = true

}



###############################################
# Cluster Protection
###############################################

variable "deletion_protection" {

  type = bool

  default = false

}




###############################################
# Node Configuration
###############################################

variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}

variable "node_disk_size" {
  type    = number
  default = 30
}

variable "node_ami_type" {
  type    = string
  default = "AL2023_x86_64_STANDARD"
}





