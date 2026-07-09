locals {

  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      ManagedBy = "Terraform"
    }
  )

  oidc_provider = replace(
    data.aws_eks_cluster.this.identity[0].oidc[0].issuer,
    "https://",
    ""
  )

}
