locals {
  resource_group_name   = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  name_prefix_kms           = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  kms_name              = var.kms_alias != "" && var.kms_alias != null ? var.kms_alias : "${local.name_prefix_kms}"
  user_name            = var.user_arn != "" && var.user_arn != null ? var.user_arn : "${data.aws_caller_identity.current.arn}"
}
data "aws_caller_identity" "current" {}
resource "aws_kms_key" "kmskey" {
  description              = var.description
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  deletion_window_in_days  = 10
  enable_key_rotation      = var.rotation_enabled  

  tags = {
    Name = "${var.alias}"
  }
    policy = <<EOF
{
    "Id": "key-consolepolicy-3",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${local.user_name}"
            },
            "Action": [
                "kms:Create*",
                "kms:Describe*",
                "kms:Enable*",
                "kms:List*",
                "kms:Put*",
                "kms:Update*",
                "kms:Revoke*",
                "kms:Disable*",
                "kms:Get*",
                "kms:Delete*",
                "kms:TagResource",
                "kms:UntagResource",
                "kms:ScheduleKeyDeletion",
                "kms:CancelKeyDeletion"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${local.user_name}"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow attachment of persistent resources",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${local.user_name}"
            },
            "Action": [
                "kms:CreateGrant",
                "kms:ListGrants",
                "kms:RevokeGrant"
            ],
            "Resource": "*",
            "Condition": {
                "Bool": {
                    "kms:GrantIsForAWSResource": "true"
                }
            }
        }
    ]
}
EOF
}


resource "aws_kms_alias" "kmsalias" {
  target_key_id = aws_kms_key.kmskey.key_id
  name         = "alias/${local.kms_name}-key"
}