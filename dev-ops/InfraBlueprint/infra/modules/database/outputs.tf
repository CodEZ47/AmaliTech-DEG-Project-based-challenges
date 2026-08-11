output "vela_db_endpoint" {
  description = "Connection endpoint for the RDS instance."
  value       = aws_db_instance.vela_db.endpoint
}

output "vela_db_sg_id" {
  description = "ID of the db-sg security group."
  value       = aws_security_group.vela_db_sg.id
}

output "vela_db_subnet_group_name" {
  description = "Name of the DB subnet group used by the RDS instance."
  value       = aws_db_instance.vela_db.db_subnet_group_name
}