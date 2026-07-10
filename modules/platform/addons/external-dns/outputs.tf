output "role_arn" {
  value = aws_iam_role.this.arn
}

output "role_name" {
  value = aws_iam_role.this.name
}


output "helm_status" {
  value = helm_release.this.status
}
