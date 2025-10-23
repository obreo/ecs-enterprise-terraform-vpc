metadata = {
    project_name = "ecs-enterprise"
    environment  = "production"
}

subnets = {
    vpc_cidr_block             = "10.9.0.0/16"
    public_subnet_cidr_blocks  = ["10.9.1.0/24", "10.9.2.0/24"]
    private_subnet_cidr_blocks = ["10.9.4.0/24", "10.9.3.0/24"] 
}

