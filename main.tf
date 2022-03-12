resource "aws_kms_key" "shared" {
  description              = "Many projects depend on this key. Please do not delete this."
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = false # rotation costs money
  is_enabled               = true
  multi_region             = false
}

resource "aws_kms_alias" "shared" {
  name          = "alias/shared-key"
  target_key_id = aws_kms_key.shared.key_id
}
