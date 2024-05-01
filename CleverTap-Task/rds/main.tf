provider "aws" {
  region = "us-east-1"
}


resource "aws_db_subnet_group" "default" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "DBSubnetGroup"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "wordpress-db"
  allocated_storage      = var.db_allocated_storage
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = true
 db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = var.rds_security_group_ids
  tags = {
    Name = "WordPressDB"
  }
}
