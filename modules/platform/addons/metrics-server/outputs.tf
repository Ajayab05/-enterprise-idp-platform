output "release_name" {

  value = helm_release.metrics_server.name

}

output "release_status" {

  value = helm_release.metrics_server.status

}
