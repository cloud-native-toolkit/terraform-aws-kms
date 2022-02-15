module "dev_kms" {
  source           = "./module"
  description      = "KMS Keys for Data Encryption"
  key_spec         = var.key_spec
  rotation_enabled = var.rotation_enabled
  enabled          = var.enabled
  region           = var.region
  alias            = var.alias
  kms_alias        = var.kms_alias
  policy_file      = var.policy_file
}