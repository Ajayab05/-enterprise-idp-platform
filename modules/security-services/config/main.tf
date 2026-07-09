###############################################
# AWS Config IAM Role
###############################################

resource "aws_iam_role" "config" {

  name = "${local.name_prefix}-config-role"

  assume_role_policy = data.aws_iam_policy_document.config_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-config-role"
    }
  )

}








###############################################
# AWS Config Managed Policy
###############################################

resource "aws_iam_role_policy_attachment" "config" {

  role = aws_iam_role.config.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"

}








###############################################
# Configuration Recorder
###############################################

resource "aws_config_configuration_recorder" "this" {

  name = var.recorder_name

  role_arn = aws_iam_role.config.arn

  recording_group {

    all_supported = true

    include_global_resource_types = true

  }

}

###############################################
# Wait for AWS Config Recorder
###############################################

resource "time_sleep" "config_recorder" {

  depends_on = [
    aws_config_configuration_recorder.this,
    aws_iam_role_policy_attachment.config
  ]

  create_duration = "20s"

}






###############################################
# Delivery Channel
###############################################
resource "aws_config_delivery_channel" "this" {

  name = var.delivery_channel_name

  s3_bucket_name = var.audit_bucket_name

  snapshot_delivery_properties {

    delivery_frequency = "TwentyFour_Hours"

  }

  depends_on = [
    time_sleep.config_recorder
  ]

}





###############################################
# Recorder Status
###############################################

resource "aws_config_configuration_recorder_status" "this" {

  name = aws_config_configuration_recorder.this.name

  is_enabled = true

  depends_on = [
    aws_config_delivery_channel.this
  ]

}









