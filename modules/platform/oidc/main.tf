###############################################
# IAM OIDC Provider
###############################################

resource "aws_iam_openid_connect_provider" "eks" {

  url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.oidc.certificates[0].sha1_fingerprint
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-oidc"
    }
  )

}
