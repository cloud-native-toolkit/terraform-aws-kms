resource "aws_kms_key" "kmskey" {
  description              = var.description
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  enable_key_rotation      = var.rotation_enabled  

  tags = {
    Name = "var.alias"
  }
  policy = file("${path.module}/script/kms-policy/var.policy")
}

resource "aws_kms_alias" "kmsalias" {
  target_key_id = aws_kms_key.kmskey.key_id
  name         = "alias/${var.kms_alias}"
}