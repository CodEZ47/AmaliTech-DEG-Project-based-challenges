variable "vela_main_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vela_public_subnet_cidrs"{
    description = "List of CIDR blocks for public subnets"
    type = list(string)
}
variable "vela_private_subnet_cidrs"{
    description = "List of CIDR blocks for private subnets"
    type = list(string)
}

variable "azs"{
    description = "List of Availability Zones to spread subnets across."
    type = list(string)
}

