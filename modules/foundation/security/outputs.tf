###############################################
# CloudWatch
###############################################

output "flow_logs_log_group_name" {
  value = aws_cloudwatch_log_group.vpc_flow_logs.name
}

output "flow_logs_log_group_arn" {
  value = aws_cloudwatch_log_group.vpc_flow_logs.arn
}

###############################################
# IAM
###############################################

output "flow_logs_role_arn" {
  value = aws_iam_role.vpc_flow_logs.arn
}

output "flow_logs_policy_arn" {
  value = aws_iam_policy.vpc_flow_logs.arn
}

###############################################
# Flow Logs
###############################################

output "flow_log_id" {
  value = aws_flow_log.vpc.id
}
