module "vpc" {
  source = "git::https://github.com/obreo/iac-modules.git//terraform/vpc?ref=main"
  name   = "ecs-enterprise-${var.metadata.environment}"
  vpc_settings = {
    vpc_cidr_block             = var.subnets.vpc_cidr_block
    public_subnet_cidr_blocks  = var.subnets.public_subnet_cidr_blocks
    private_subnet_cidr_blocks = var.subnets.private_subnet_cidr_blocks
    create_private_subnets_nat = { nat_per_az = false } # Optional
    availability_zones         = ["us-east-1a", "us-east-1b"] # Optional
    enable_dns_hostnames       = true # Optional
  }
  security_groups = {}
}

module "ecs-enterprise-alb-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ecs-enterprise-alb-sg"
  description = "Security group for public access on http and https"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ecs-enterprise-frontend-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ecs-enterprise-frontend-sg"
  description = "Security group for user-service with HTTP port open within VPC"
  vpc_id      = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      source_security_group_id = module.ecs-enterprise-alb-sg.security_group_id
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ecs-enterprise-backend-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ecs-enterprise-backend-sg"
  description = "Security group for frontend tier access"
  vpc_id      = module.vpc.vpc_id
  ingress_with_source_security_group_id = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "exposing backend ports forfrontend access"
      source_security_group_id = module.ecs-enterprise-frontend-sg.security_group_id
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "exposing backend ports forfrontend access"
      source_security_group_id = module.ecs-enterprise-alb-sg.security_group_id
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}