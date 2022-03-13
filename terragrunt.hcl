locals {
  backend_path = "terraform-states-${get_aws_account_id()}-shared-kms-key"
  accounts     = jsondecode(run_cmd("aws", "organizations", "list-accounts", "--query", "Accounts[].{id:Id,name:Name}"))
}

inputs = {
  circleci_account_id = [for a in local.accounts : a if a.name == "public-circleci"][0].id
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
