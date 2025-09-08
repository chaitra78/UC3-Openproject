variable "cidr_block"{
    type = list(string)
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "vpc_id" {
  description = "The ID of the VPC where subnets will be created"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for subnet distribution"
  type        = list(string)
}
