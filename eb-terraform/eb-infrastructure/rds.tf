#1. CREATE RDS SUBNET GROUP
resource "aws_db_subnet_group" "ebullion-db-private-subnetgroup" {
name = var.db-subnet-group-name
subnet_ids = [aws_subnet.ebullion-private-subnet-1.id, aws_subnet.ebullion-private-subnet-2.id, aws_subnet.ebullion-public-subnet-1.id ]
#subnet_ids =  ["${var.subnet1}", "${var.subnet2}", "${var.subnet3}"]
}

#2. CREAE RDS DATABASE
resource "aws_db_instance" "default" {
allocated_storage = var.db-storage
identifier = var.db-name
storage_type = var.db-storage-type
engine = var.db-engine
engine_version = var.db-engine-version
instance_class = var.db-instance-type
db_name = var.db-database-name
username = var.db-username
password = var.db-password
publicly_accessible = false
parameter_group_name = "${ aws_db_parameter_group.default.name}"
db_subnet_group_name = "${ aws_db_subnet_group.ebullion-db-private-subnetgroup.name}"
skip_final_snapshot = "true"
vpc_security_group_ids   = ["${aws_security_group.eb-rds-pre-prod-sg.id}"]
backup_retention_period = var.backup_retention_period
backup_window = var.backup_window
}




#3. CREATE RDS SECURITY GROUP
resource "aws_security_group" "eb-rds-pre-prod-sg" {
  name = "eb-rds-pre-prod-sg"

  description = "RDS postgres servers (terraform-managed)"
  vpc_id = aws_vpc.ebullion-vpc.id

  # Only postgres inbound
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#4. CREATE DB PARAMETERE GROUP
resource "aws_db_parameter_group" "default" {
  name   = "eb-pre-prod-parametere-group"
  family = "postgres13"
}
