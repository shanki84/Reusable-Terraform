// Module specific variables

variable "env" {
  description = "name of the environment"
}

variable "cidr-vpc" {
  description = "The VPC the instance(s) will go in"
}

variable "cidr-subnet" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "region" {
  description = "The AMI to use"
}


variable "image-id" {
  description = "The AMI to use"
}

variable "number_of_instances" {
  description = "number of instances to be added"
}

variable "instance-type" {
  description = "type of instance"
}

variable "desired-capacity" {
  description = "number if instance required"
}

variable "max_size" {
  description = "max number of required instances"
}

variable "min_size" {
  description = "min number of required instances"
}
