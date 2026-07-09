###############################################
# GuardDuty Detector
###############################################

resource "aws_guardduty_detector" "this" {

  enable = var.enable_guardduty

  finding_publishing_frequency = var.finding_publishing_frequency

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-guardduty"
    }
  )

}
