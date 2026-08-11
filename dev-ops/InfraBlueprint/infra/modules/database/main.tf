resource "aws_db_subnet_group" "vela_db_subnet_group" {
  name       = "vela-db-subnet-group"
  subnet_ids = var.vela_private_subnet_ids

  description = "Private subnets for Vela RDS instance"
}

resource "aws_security_group" "vela_db_sg" {
  name        = "db-sg"
  description = "Allow PostgreSQL only from web-sg"
  vpc_id      = var.vela_vpc_id

  ingress {
    description     = "PostgreSQL from web-sg only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.vela_web_sg_id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "vela_db" {
  identifier     = "vela-db"
  engine         = "postgres"
  engine_version = "15"
  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "veladb"
  username = var.vela_db_username
  password = var.vela_db_password

  db_subnet_group_name   = aws_db_subnet_group.vela_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.vela_db_sg.id]

  publicly_accessible = false
  skip_final_snapshot       = var.vela_skip_final_snapshot
  final_snapshot_identifier = "vela-db-final-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"

  lifecycle {
    ignore_changes = [final_snapshot_identifier]
  }
}