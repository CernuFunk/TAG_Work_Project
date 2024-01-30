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


resource "random_string" "DB-main-db-password" {
  length  = 32
  upper   = true
  number  = true
  special = false
}
resource "aws_security_group" "DB-main" {
  vpc_id      = "${data.aws_vpc.default.id}"
  name        = "DB-main"
  description = "Allow all inbound for Postgres"ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_block ## Utente assegna blocco CIDR del database
  }
}
resource "aws_db_instance" "MooV-DB" {
  identifier             = "MooV-DB"
  name                   = "DB-Main"
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "12.5"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.DB-main.id]
  username               = "sameed"
  password               = "random_string.DB-main-db-password.result}"
  
  }