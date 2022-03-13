data "aws_caller_identity" "self" {}

resource "aws_kms_key" "shared" {
  description              = "Many projects depend on this key. Please do not delete this."
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = false # rotation costs money
  is_enabled               = true
  multi_region             = false
  policy = jsonencode({
    "Id" : "key-default-1",
    "Statement" : [
      {
        "Action" : "kms:*",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.self.account_id}:root"
        },
        "Resource" : "*",
        "Sid" : "Enable IAM User Permissions"
      }
    ],
    "Version" : "2012-10-17"
  })
}

resource "aws_kms_alias" "shared" {
  name          = "alias/shared-key"
  target_key_id = aws_kms_key.shared.key_id
}
