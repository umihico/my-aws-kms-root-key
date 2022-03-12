locals {
  backend_path = "terraform-states-${get_aws_account_id()}-shared-kms-key"
}

remote_state {
  backend = "s3"
  generate = {
    path              = "remote_state_override.tf"
    if_exists         = "overwrite"
    disable_signature = true
  }
  config = {
    region               = "ap-northeast-1"
    dynamodb_table       = local.backend_path
    bucket               = local.backend_path
    key                  = "${path_relative_to_include()}/terraform.tfstate"
    encrypt              = true
    workspace_key_prefix = "workspaces"
  }
}

generate "provider" {
  path              = "provider_override.tf"
  if_exists         = "overwrite"
  disable_signature = true
  contents          = <<EOF
provider "aws" {
  region  = "ap-northeast-1"
}
EOF
}
