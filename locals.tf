locals {
  environment = "dev"
  common_tags = {
    Environment = local.environment
    Project     = "Devops Lab"
    ManagedBy   = "Terraform"
  }

}
