output "db_endpoint" {
  value       = aws_db_instance.education_db.endpoint
  description = "Database connection endpoint"
}