#1. EKS CLUSTER VARIABLES -----------------------------------------------------------------------------------------------------------
aws_region = "ap-south-1"
cluster-name = "ebullion-pre-prod-eks-cluster"
#vpc_id = "vpc-006ef9912560dcdc8"
node-instance-type = "t2.medium"
desired-instance-count = "0"
max-instance-count = "1"
min-instance-count = "0"
eks-nodes-name = "eb-pre-prod-node"
vendor = "Neosoft"

#2. VPC VARIABLES ----------------------------------------------------------------------------------------------------------------

#aws_region = "ap-south-1"
cidr-block1 = "192.168.0.0/16"
vpc-name = "ebullion-pre-prod-vpc"

public-2-cidr = "192.168.192.0/18"
public-2-az = "ap-south-1b"
public-subnet-2-name = "ebullon-pre-prod-public-subnet-2"

public-1-cidr = "192.168.0.0/18"
public-1-az = "ap-south-1a"
public-subnet-1-name = "ebullon-pre-prod-public-subnet-1"

private-1-cidr = "192.168.128.0/18"
private-1-az = "ap-south-1a"
private-subnet-1-name = "ebullon-pre-prod-private-subnet-1"

private-2-cidr = "192.168.64.0/18"
private-2-az = "ap-south-1b"
private-subnet-2-name = "ebullon-pre-prod-private-subnet-2"


igw-name = "ebullon-pre-prod-private-igw"
public-rt-1-name = "ebullon-pre-prod-public-rt-1"
public-rt-2-name = "ebullon-pre-prod-public-rt-2"
eip-name = "ebullon-pre-prod-eip"
nat-name = "ebullon-pre-prod-nat"
private-rt-1-name = "ebullon-pre-prod-private-rt-1"
private-rt-2-name = "ebullon-pre-prod-private-rt-2"


#3. EC2 VARIABLES --------------------------------------------------------------------------------------------------------------------
ec2-instance-type = "t2.micro"
ec2-key           = "eb-pre-prod-bastion"
ports             = [22]
name = "eb-pre-prod-bastion"
ec2-sg-description = "Pre Production Bastion Host"
ec2-sg-name = "eb-pre-prod-sg"
ec2-name = "eb-pre-prod-bastion"


#4. RDS VARIABLES -----------------------------------------------------------------------------------------------------------------
db-subnet-group-name = "eb-pre-prod-subnet-group"
db-storage = 30
db-name = "eb-pre-prod-db"
db-storage-type = "gp2"
db-engine = "postgres"
db-engine-version = "13.6"
db-instance-type = "db.t3.small"
db-database-name = "ebullion_preprod"
db-username = "ebullion_preprod"
db-password = "O9K4k8Jzm2Nx8hss"
db-parametere-group-name = "eb-pre-prod-parametere-group"
backup_window = "00:00-02:00"
backup_retention_period = "7"




