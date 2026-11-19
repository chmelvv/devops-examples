resource "aws_db_instance" "education_db" {
  identifier             = "student-demo-db"
  allocated_storage      = 20
  max_allocated_storage  = 25
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"
  db_name                = "shopdb"
  username               = "dbadmin"
  password               = "SuperSecretPass123!" # Demonstration password
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true 
  
  # Association with network settings:
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}