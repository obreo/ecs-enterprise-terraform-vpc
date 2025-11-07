output "security_group_ids" {
  description = "All ECS enterprise security group IDs"
  value = {
    alb_sg       = module.ecs-enterprise-alb-sg.security_group_id
    frontend_sg  = module.ecs-enterprise-frontend-sg.security_group_id
    backend_sg   = module.ecs-enterprise-backend-sg.security_group_id
  }
}

output "public_subnet_cidr_blocks" {
  description = "List of private subnet CIDR blocks"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "private_subnet_cidr_blocks" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_cidr_blocks
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_route_table_id" {
  description = "Default security group ID"
  value       = module.vpc.public_route_table_id
}

output "private_route_table_id" {
  description = "Default security group ID"
  value       = module.vpc.private_route_table_id
}