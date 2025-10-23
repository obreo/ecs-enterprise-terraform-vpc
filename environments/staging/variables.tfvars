metadata = {
    project_name = "ecs-enterprise"
    environment  = "staging"
}

subnets = {
    vpc_cidr_block             = "10.11.0.0/16"
    public_subnet_cidr_blocks  = ["10.11.1.0/24", "10.11.2.0/24"]
    private_subnet_cidr_blocks = ["10.11.4.0/24", "10.11.3.0/24"]
}

