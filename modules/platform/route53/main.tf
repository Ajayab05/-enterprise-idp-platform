###############################################
# Public Hosted Zone
###############################################

resource "aws_route53_zone" "this" {

  name = var.domain_name

  comment = "Enterprise Platform Public Hosted Zone"

  force_destroy = false

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-hosted-zone"
    }
  )

}
