###############################################
# Amazon ECR Repositories
###############################################

resource "aws_ecr_repository" "this" {

  for_each = toset(var.repositories)

  name = each.value

  image_tag_mutability = var.image_tag_mutability

  force_delete = var.force_delete

  encryption_configuration {

    encryption_type = "KMS"

  }

  image_scanning_configuration {

    scan_on_push = true

  }

  tags = merge(
    local.common_tags,
    {
      Name = each.value
    }
  )

}


###############################################
# ECR Lifecycle Policy
###############################################

resource "aws_ecr_lifecycle_policy" "this" {

  for_each = aws_ecr_repository.this

  repository = each.value.name

  policy = jsonencode({

    rules = [

      {

        rulePriority = 1

        description = "Keep last 20 images"

        selection = {

          tagStatus = "any"

          countType = "imageCountMoreThan"

          countNumber = 20

        }

        action = {

          type = "expire"

        }

      }

    ]

  })

}


###############################################
# ECR Repository Policy
###############################################

data "aws_iam_policy_document" "repository" {

  for_each = aws_ecr_repository.this

  statement {

    sid = "AccountAccess"

    effect = "Allow"

    principals {

      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]

    }

    actions = [
      "ecr:*"
    ]

  }

}

resource "aws_ecr_repository_policy" "this" {

  for_each = aws_ecr_repository.this

  repository = each.value.name

  policy = data.aws_iam_policy_document.repository[each.key].json

}
