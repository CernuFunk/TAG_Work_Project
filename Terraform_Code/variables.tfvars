##Variabili da usare nel main 



variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-south-1"
}

variable "what_ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = null
}
