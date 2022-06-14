locals {
  resource_group_name   = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  name_prefix_kms           = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  kms_name              = var.kms_alias != "" && var.kms_alias != null ? var.kms_alias : "${local.name_prefix_kms}"
}
resource "aws_kms_key" "kmskey" {
  description              = var.description
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  enable_key_rotation      = var.rotation_enabled  

  tags = {
    Name = "${var.alias}"
  }
  policy = file("${path.module}/${var.policy_file}")
}

resource "aws_kms_alias" "kmsalias" {
  target_key_id = aws_kms_key.kmskey.key_id
  name         = "alias/${local.kms_name}-key"
}