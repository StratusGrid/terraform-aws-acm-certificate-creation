locals {
  common_tags = {
    Environment = var.env_name
    SourceRepo  = var.source_repo
    Developer   = "StratusGrid"
    Provisioner = "Terraform"
    Terraform   = "true"
    ModuleSourceRepo = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"
  }
}

//locals {
//  local_tags = merge(var.input_tags, {
//    "ModuleSourceRepo" = "github.com/StratusGrid/terraform-aws-acm-certificate-creation"
//  })
//}