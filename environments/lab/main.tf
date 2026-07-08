module "terraform_backend" {

  source = "../../modules/foundation/backend"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  tags = var.tags

}



module "networking" {

  source = "../../modules/foundation/networking"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones

  public_subnet_cidrs = var.public_subnet_cidrs

  private_app_subnet_cidrs = var.private_app_subnet_cidrs

  private_db_subnet_cidrs = var.private_db_subnet_cidrs

  single_nat_gateway = var.single_nat_gateway

  tags = var.tags
}




module "security" {

  source = "../../modules/foundation/security"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  vpc_id = module.networking.vpc_id

  tags = var.tags
}








module "github_oidc" {

  source = "../../modules/platform/github-oidc"

  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region

  repository_name = var.repository_name
  owner           = var.owner

  github_organization = var.github_organization
  github_repositories = var.github_repositories
  github_branch       = var.github_branch

  tags = var.tags
}



















