###############################################
# Metrics Server
###############################################

resource "helm_release" "metrics_server" {

  name = local.release_name

  repository = "https://kubernetes-sigs.github.io/metrics-server/"

  chart = "metrics-server"

  version = var.chart_version

  namespace = var.namespace

  create_namespace = false

  atomic = true

  cleanup_on_fail = true

  wait = true

  timeout = 600

  values = [

    <<EOF

args:
  - --kubelet-preferred-address-types=InternalIP
  - --kubelet-use-node-status-port

replicas: 2

podDisruptionBudget:
  enabled: true
  minAvailable: 1

resources:

  requests:
    cpu: 100m
    memory: 200Mi

  limits:
    cpu: 200m
    memory: 300Mi

EOF

  ]

}
