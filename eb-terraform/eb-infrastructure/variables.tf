#EKS CLUSTER---------------------------------------------------------------------------------------------------------------------------------
variable "cluster-name" {
  default = "prod-eks-cluster"
  type    = string
}
variable "node-instance-type" {
}
variable "desired-instance-count" {
}
variable "max-instance-count" {
}
variable "min-instance-count" {
}
variable "eks-nodes-name" {
}
variable "vendor" {
}



#VPC-----------------------------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  default = "ap-south-1"
}
variable "cidr-block1" {
}
variable "vpc-name" {
}

variable "public-2-cidr" {
}
variable "public-2-az" {
}
variable "public-subnet-2-name" {
}
variable "public-1-cidr" {
}
variable "public-1-az" {
}
variable "public-subnet-1-name" {
}
variable "private-1-cidr" {
}
variable "private-1-az" {
}
variable "private-subnet-1-name" {
}
variable "private-2-cidr" {
}
variable "private-2-az" {
}
variable "private-subnet-2-name" {
}
variable "igw-name" {
}
variable "public-rt-1-name" {
}
variable "public-rt-2-name" {
}
variable "eip-name" {
}
variable "nat-name" {
}
variable "private-rt-1-name" {
}
variable "private-rt-2-name" {
}


#EC2---------------------------------------------------------------------------------------------------------------------------

variable "ec2-instance-type" {
}
variable "ec2-key" {
}
variable "ports" {
}
variable "name" {
}
variable "ec2-sg-description" {
}
variable "ec2-sg-name" {
}
variable "ec2-name" {
}


#RDS-----------------------------------------------------------------------------------------------------------------------------
variable "db-subnet-group-name" {
}
variable "db-storage" {
}
variable "db-name" {
}
variable "db-storage-type" {
}
variable "db-engine" {
}
variable "db-engine-version" {
}
variable "db-instance-type" {
}
variable "db-database-name" {
}
variable "db-username" {
}
variable "db-password" {
}
variable "db-parametere-group-name" {
}
variable "backup_retention_period" {
}
variable "backup_window" {
}







