###############################################
# CloudWatch Log Group for VPC Flow Logs
###############################################

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {

  name = "/aws/vpc/${local.name_prefix}/flowlogs"

  retention_in_days = 90

  kms_key_id = null

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flowlogs"
    }
  )
}


###############################################
# IAM Trust Policy for VPC Flow Logs
###############################################

data "aws_iam_policy_document" "flow_logs_assume_role" {

  statement {

    sid = "VPCFlowLogsAssumeRole"

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "vpc-flow-logs.amazonaws.com"
      ]

    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}



###############################################
# IAM Role for VPC Flow Logs
###############################################

resource "aws_iam_role" "vpc_flow_logs" {

  name = "${local.name_prefix}-vpc-flowlogs-role"

  assume_role_policy = data.aws_iam_policy_document.flow_logs_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flowlogs-role"
    }
  )

}


###############################################
# IAM Policy Document for VPC Flow Logs
###############################################

data "aws_iam_policy_document" "vpc_flow_logs" {

  statement {

    sid    = "CloudWatchLogsAccess"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]

    resources = [
      "${aws_cloudwatch_log_group.vpc_flow_logs.arn}:*",
      aws_cloudwatch_log_group.vpc_flow_logs.arn
    ]
  }
}
###############################################
# IAM Policy
###############################################

resource "aws_iam_policy" "vpc_flow_logs" {

  name        = "${local.name_prefix}-vpc-flowlogs-policy"

  description = "IAM Policy for VPC Flow Logs"

  policy = data.aws_iam_policy_document.vpc_flow_logs.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flowlogs-policy"
    }
  )

}


###############################################
# IAM Policy Attachment
###############################################

resource "aws_iam_role_policy_attachment" "vpc_flow_logs" {

  role = aws_iam_role.vpc_flow_logs.name

  policy_arn = aws_iam_policy.vpc_flow_logs.arn

}



###############################################
# VPC Flow Logs
###############################################

resource "aws_flow_log" "vpc" {

  log_destination_type = "cloud-watch-logs"

  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn

  iam_role_arn = aws_iam_role.vpc_flow_logs.arn

  traffic_type = "ALL"

  vpc_id = var.vpc_id

  max_aggregation_interval = 60

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-vpc-flowlogs"
    }
  )

  depends_on = [
    aws_cloudwatch_log_group.vpc_flow_logs,
    aws_iam_role_policy_attachment.vpc_flow_logs
  ]
}
