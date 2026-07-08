locals {

  common_tags = merge(

    {

      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Terraform   = "true"
      Repository  = var.repository_name
      Owner       = var.owner

    },

    var.tags

  )

}
