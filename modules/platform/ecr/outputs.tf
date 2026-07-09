###############################################
# ECR Repository Names
###############################################

output "repository_names" {

  description = "ECR Repository Names"

  value = {
    for repo, resource in aws_ecr_repository.this :
    repo => resource.name
  }

}

###############################################
# ECR Repository URLs
###############################################

output "repository_urls" {

  description = "ECR Repository URLs"

  value = {
    for repo, resource in aws_ecr_repository.this :
    repo => resource.repository_url
  }

}

###############################################
# Repository ARNs
###############################################

output "repository_arns" {

  description = "Repository ARNs"

  value = {
    for repo, resource in aws_ecr_repository.this :
    repo => resource.arn
  }

}
