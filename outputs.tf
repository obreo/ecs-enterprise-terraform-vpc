# output "security_group_ids" {
#   description = "Default security group ID"
#   value       = module.vpc.security_group_ids
# }

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