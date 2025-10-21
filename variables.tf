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
    public_subnets  = list(string)
    private_subnets = list(string)
  })
}