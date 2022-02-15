output "key_arn" {
  value       = aws_kms_key.kmskey.arn
  description = "Key ARN"
}

output "key_id" {
  value       = aws_kms_key.kmskey.key_id
  description = "Key ID"
}

output "alias_arn" {
  value       = aws_kms_alias.kmsalias.arn
  description = "Alias ARN"
}

output "alias_name" {
  value       = aws_kms_alias.kmsalias.name
  description = "Alias name"
}
