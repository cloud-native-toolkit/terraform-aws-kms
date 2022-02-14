module "dev_tools_mymodule" {
  source           = "./module"
  description      = "KMS Keys for Data Encryption"
  key_spec         = "SYMMETRIC_DEFAULT"
  rotation_enabled = "true"
  enabled          = "true"
  region           = "us-east-1"
  alias            = "kms-storage"
  kms_alias        = "kms-storage-swe"
}
