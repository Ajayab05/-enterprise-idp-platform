output "inspector_account" {

  value = data.aws_caller_identity.current.account_id

}

output "enabled_resource_types" {

  value = aws_inspector2_enabler.this.resource_types

}
