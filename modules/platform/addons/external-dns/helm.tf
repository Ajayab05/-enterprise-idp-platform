###############################################
# ExternalDNS
###############################################

resource "helm_release" "this" {

  name = "external-dns"

  repository = "https://kubernetes-sigs.github.io/external-dns"

  chart = "external-dns"

  namespace = "kube-system"

  version = "1.19.0"

  wait    = true
  atomic  = true
  timeout = 900

  values = [

    <<EOF

provider: aws

policy: sync

registry: txt

txtOwnerId: ${var.hosted_zone_id}

domainFilters:
  - ${var.domain_name}

serviceAccount:

  create: true

  name: external-dns

  annotations:

    eks.amazonaws.com/role-arn: ${aws_iam_role.this.arn}

aws:

  region: us-east-1

sources:
  - service
  - ingress

logLevel: info

interval: 1m

EOF

  ]

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]

}
