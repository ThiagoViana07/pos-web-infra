output "rds_endpoint" {
  value = aws_db_instance.myapp_db.address
}