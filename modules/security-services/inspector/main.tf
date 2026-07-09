###############################################
# Enable Inspector
###############################################

resource "aws_inspector2_enabler" "this" {

  account_ids = [
    data.aws_caller_identity.current.account_id
  ]

  resource_types = compact([
    var.enable_ec2 ? "EC2" : "",
    var.enable_ecr ? "ECR" : "",
    var.enable_lambda ? "LAMBDA" : ""
  ])

}
