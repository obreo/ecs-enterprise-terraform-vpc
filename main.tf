module "vpc" {
  source = "git::https://github.com/obreo/iac-modules.git//terraform/vpc?ref=main"
  name   = "ecs-enterprise-${var.metadata.environment}"
  vpc_settings = {
    vpc_cidr_block             = var.subnets.vpc_cidr_block
    public_subnet_cidr_blocks  = var.subnets.public_subnet_cidr_blocks
    private_subnet_cidr_blocks = var.subnets.private_subnet_cidr_blocks
    create_private_subnets_nat = { nat_per_az = false } # Optional
    availability_zones         = ["eu-north-1a", "eu-north-1b"] # Optional
    enable_dns_hostnames       = true # Optional
  }
  security_groups = {
    "ecs-enterprise-frontend" = {
      name        = "ecs-enterprise-frontend-sg"
      description = "App security group"
      tags        = { "env" = "${var.metadata.environment}" }
      inbound = {
        rule_description = "Allow HTTP"
        ports           = [80, 443]
        ip_protocol     = "tcp"
        destination = {
          cidr_ipv4      = "0.0.0.0/0"
          cidr_ipv6      = null
          security_group = null
          prefix_list_id = null
        }
      }
    }
  }
}