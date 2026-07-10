###############################################
# EBS CSI IAM Role
###############################################

resource "aws_iam_role" "ebs_csi" {

  name = "${local.name_prefix}-ebs-csi-role"

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-ebs-csi-role"
    }
  )

}

###############################################
# AWS Managed Policy
###############################################

resource "aws_iam_role_policy_attachment" "ebs_csi" {

  role = aws_iam_role.ebs_csi.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

}
