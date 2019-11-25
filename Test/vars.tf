variable "env" {
  default = "TEST"
}

# ---- Network -------------- #

variable "cidr-vpc" {
  description = "VPC"
  default = "10.43.10.0/24"
}
variable "cidr-subnet" {
  description = "subnet"
  default = "10.43.10"
}

# ---- Auto Scalling Group ---- #

variable "region" {
  default = "eu-west-2"
}

variable "image-id" {
  default = "ami-0d69ab00cb41d6eda"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default = 3
}

variable "instance-type" {
  default = "t2.medium"
}

variable "desired-capacity" {
  description = "How many desired nodes to create"
  default = 3
}
variable "max_size" {
  description = "How many max_size nodes to create"
  default = 7
}
variable "min_size" {
  description = "How many min_size nodes to create"
  default = 3
}
