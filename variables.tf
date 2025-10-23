variable "metadata" {
  description = "General info about the project"
    type        = object({
        project_name = string
        environment  = string
    })
}
variable "subnets" {
  description = "List of subnet IDs"
  type        = object({
    vpc_cidr_block             = string
    public_subnet_cidr_blocks  = list(string)
    private_subnet_cidr_blocks = list(string)
  })
}