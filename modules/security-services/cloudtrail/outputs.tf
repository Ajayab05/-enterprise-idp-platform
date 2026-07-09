output "cloudtrail_arn" {
  value = aws_cloudtrail.this.arn
}

output "cloudtrail_home_region" {
  value = aws_cloudtrail.this.home_region
}

output "cloudtrail_name" {
  value = aws_cloudtrail.this.name
}
