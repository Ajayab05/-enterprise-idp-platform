resource "helm_release" "karpenter" {
  name             = "karpenter"
  namespace        = "kube-system"
  create_namespace = false

  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "1.8.2"

  wait             = true
  timeout          = 900
  cleanup_on_fail  = true
  atomic           = true

  values = [
    yamlencode({

      replicas = 2

      serviceAccount = {
        create = true
        name   = "karpenter"

        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
        }
      }

      settings = {
        clusterName      = var.cluster_name
        clusterEndpoint  = var.cluster_endpoint
        interruptionQueue = var.cluster_name
      }

      controller = {
        resources = {
          requests = {
            cpu    = "500m"
            memory = "512Mi"
          }

          limits = {
            cpu    = "1"
            memory = "1Gi"
          }
        }
      }

    })
  ]
}
