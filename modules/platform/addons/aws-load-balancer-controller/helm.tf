###############################################
# AWS Load Balancer Controller
###############################################

resource "helm_release" "this" {

  name = "aws-load-balancer-controller"

  repository = "https://aws.github.io/eks-charts"

  chart = "aws-load-balancer-controller"

  namespace = "kube-system"

  version = "1.13.0"

  wait    = true
  atomic  = true
  timeout = 900

  values = [

    <<EOF

clusterName: ${var.cluster_name}

serviceAccount:

  create: true

  name: aws-load-balancer-controller

  annotations:

    eks.amazonaws.com/role-arn: ${aws_iam_role.this.arn}

region: us-east-1

vpcId: ${data.aws_eks_cluster.this.vpc_config[0].vpc_id}

replicaCount: 2

enableShield: true

enableWaf: true

enableWafv2: true

EOF

  ]

  depends_on = [
    aws_iam_role_policy_attachment.this
  ]

}
