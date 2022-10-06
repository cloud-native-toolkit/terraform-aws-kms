variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}
variable "name_prefix" {
  type        = string
  description = "Prefix to be added to the names of resources which are being provisioned"
  default     = ""
}
variable "description" {
  type        = string
  default = "Storage-kms"
  description = "The description of the key as viewed in AWS console."
}

variable "key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, or ECC_SECG_P256K1"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the key is enabled."
}

variable "policy_file" {
  type        = string
  default     = "scripts/kms-policy/kms-policy.json"
 description = "Specifies the file name for kms policy."
}

variable "user_arn" {
  type        = string
  default     = ""
 description = "arn of the user for the kms key access."
}

variable "rotation_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled."
}

variable "alias" {
  type        = string
  default = "Storage-kms"
  description = "The display name of the key."
}

variable "region" {
  type        = string
  default = "us-west-2"
}

variable "kms_alias" {
  type        = string
  default = ""
  description = "The description of the key alias as viewed in AWS console"
}