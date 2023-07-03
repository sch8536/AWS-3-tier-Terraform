# Creating RDS Instance
resource "aws_db_subnet_group" "PROmet-dbsubnetgroup" {
  name       = "main"
  subnet_ids = [aws_subnet.database-subnet-1.id, aws_subnet.database-subnet-2.id]
  
  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "PROmet-DB" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.PROmet-dbsubnetgroup.id
  engine                 = "mariadb"
  engine_version         = "10.6.11"
  instance_class         = "db.t2.micro"
  multi_az               = false
  db_name                = "prometdb"
  username               = "admin"
  password               = "admin13!#"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.DB-sg.id]
  backup_retention_period = 7
}

resource "aws_db_instance" "PROmet-DB-read-replica" {
  count                  = 1
  identifier             = "promet-db-read-replica-${count.index}"
  instance_class         = "db.t2.micro"
  publicly_accessible    = false
  replicate_source_db    = aws_db_instance.PROmet-DB.id
  skip_final_snapshot    = true

  tags = {
    Name = "PROmet-DB-read-replica"
  }
}

