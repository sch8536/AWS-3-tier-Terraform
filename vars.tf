# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Public Subnets
variable "subnet_cidr" {
  default = "10.0.1.0/26"
}

variable "subnet1_cidr" {
  default = "10.0.2.0/26"
}

# WAS Subnets
variable "subnet2_cidr" {
  default = "10.0.3.0/26"
}

variable "subnet3_cidr" {
  default = "10.0.4.0/26"
}

# Database Subnets
variable "subnet4_cidr" {
  default = "10.0.5.0/26"
}

variable "subnet5_cidr" {
  default = "10.0.6.0/26" 
}

