output "hosted_zone_id" {

  value = aws_route53_zone.this.zone_id

}

output "hosted_zone_arn" {

  value = aws_route53_zone.this.arn

}

output "name_servers" {

  value = aws_route53_zone.this.name_servers

}

output "domain_name" {

  value = aws_route53_zone.this.name

}
