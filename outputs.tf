output "shared_kms_key" {
  value = aws_kms_key.shared
}
output "shared_kms_alias" {
  value = aws_kms_alias.shared
}
