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
  description = "ID of AMI to use for the instance" ## 	ami-0ae12517fe595ce17 for South Region
  type        = string
  default     = null
}

variable "what_az"{
  description = "ID of AZ to use for the instance" ## 	ami-0ae12517fe595ce17 for South Region
  type        = string
  default     = null

}

variable "ip_address" {
  description = "IP for Instance "
  type        = string
  default     = null
}