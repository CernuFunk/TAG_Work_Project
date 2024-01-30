terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
        source = "MOOV/aws"
        version ="-> 3.27"
    }

  }
  
}

provider "aws" {

    region = var.aws_region

}

resource "aws_instance" "app_server" {
    ami                          = var.what_ami 
    arn                          = "arn:aws:ec2:eu-south-1:account-id:instance/resource-id" ##Lasciando componenti arn in default poichè sconosciuto
    associate_public_ip_address  = true
    availability_zone            = var.what_az ##
    cpu_core_count               = 2
    cpu_threads_per_core         = 4
    disable_api_termination      = false
    ebs_optimized                = false
    get_password_data            = false
    hibernation                  = false
    id                           = "resource-id" ##Lasciando Resource-id in default poichè sconosciuto
    instance_state               = "running"
    instance_type                = "t4g.medium"
    ipv6_address_count           = 0
    ipv6_addresses               = []
    monitoring                   = false
    primary_network_interface_id = "nomeeni" 
    private_dns                  = var.ip_address+".eu-south-1.compute.internal" 
    private_ip                   = "ipv4localaddress" 
    secondary_private_ips        = []
    security_groups              = [
        "default",
    ]

    tags{
        Name= var.instance_name ##Permette al lancio del codice di decidere nome dell'instanza
    }

}
