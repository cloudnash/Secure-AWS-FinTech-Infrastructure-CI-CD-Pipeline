resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "fintech-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id] # Requires 2 AZs usually, simplified here
}

resource "aws_db_instance" "postgres" {
  identifier             = "fintech-payroll-db"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  username               = "dbadmin"
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  skip_final_snapshot    = true
  storage_encrypted      = true # GDPR Compliance: Encryption at rest

  tags = {
    Name = "FinTech-Payroll-DB"
  }
}
