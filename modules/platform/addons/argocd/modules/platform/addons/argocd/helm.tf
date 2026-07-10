resource "helm_release" "this" {

  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"

  chart = "argo-cd"

  namespace = "argocd"

  create_namespace = true

  version = "8.3.6"

  wait = true

  atomic = true

  timeout = 900

}
