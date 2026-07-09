###############################################
# EKS Managed Node Launch Template
###############################################

resource "aws_launch_template" "node" {

  name_prefix = "${local.name_prefix}-eks-node-"

  update_default_version = true

  ###############################################
  # Instance Type
  ###############################################

  instance_type = var.node_instance_type

  ###############################################
  # IMDSv2
  ###############################################

  metadata_options {

    http_endpoint = "enabled"

    http_tokens = "required"

    http_put_response_hop_limit = 2

  }

  ###############################################
  # Monitoring
  ###############################################

  monitoring {

    enabled = true

  }

  ###############################################
  # Root Volume
  ###############################################

  block_device_mappings {

    device_name = "/dev/xvda"

    ebs {

      volume_size = var.node_disk_size

      volume_type = "gp3"

      encrypted = true

      delete_on_termination = true

    }

  }

  ###############################################
  # Tags
  ###############################################

  tag_specifications {

    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-eks-node"
      }
    )

  }

  tag_specifications {

    resource_type = "volume"

    tags = merge(
      local.common_tags,
      {
        Name = "${local.name_prefix}-eks-volume"
      }
    )

  }

}
