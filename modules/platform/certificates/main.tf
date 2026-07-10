###############################################
# ACM Certificate
###############################################

resource "aws_acm_certificate" "this" {

  domain_name = var.domain_name

  validation_method = "DNS"

  lifecycle {

    create_before_destroy = true

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-acm"
    }
  )

}

###############################################
# Route53 Validation Record
###############################################

resource "aws_route53_record" "validation" {

  for_each = {

    for dvo in aws_acm_certificate.this.domain_validation_options :

    dvo.domain_name => {

      name   = dvo.resource_record_name

      record = dvo.resource_record_value

      type   = dvo.resource_record_type

    }

  }

  zone_id = var.hosted_zone_id

  allow_overwrite = true

  name = each.value.name

  records = [

    each.value.record

  ]

  ttl = 60

  type = each.value.type

}

###############################################
# ACM Validation
###############################################

resource "aws_acm_certificate_validation" "this" {

  certificate_arn = aws_acm_certificate.this.arn

  validation_record_fqdns = [

    for record in aws_route53_record.validation :

    record.fqdn

  ]

}
