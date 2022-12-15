#VPC
resource "aws_vpc" "ebullion-vpc" {
  cidr_block           = var.cidr-block1
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = tomap({
    Name    = "${var.vpc-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}

#PUBLIC SUBNET 1
resource "aws_subnet" "ebullion-public-subnet-2" {
  vpc_id                  = aws_vpc.ebullion-vpc.id
  cidr_block              = var.public-2-cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.public-2-az
  tags = tomap({
    Name    = "${var.public-subnet-2-name}",
    ProvisioningVendor = "${var.vendor}",
    "kubernetes.io/role/elb" = "1"

  })
}

#PUBLIC SUBNET 2
resource "aws_subnet" "ebullion-public-subnet-1" {
  vpc_id                  = aws_vpc.ebullion-vpc.id
  cidr_block              = var.public-1-cidr
  map_public_ip_on_launch = "true"
  availability_zone       = var.public-1-az
  tags = tomap({
    Name    = "${var.public-subnet-1-name}",
    ProvisioningVendor = "${var.vendor}",
    "kubernetes.io/role/elb" = "1"
  })
}


#PRIVATE SUBNET 1
resource "aws_subnet" "ebullion-private-subnet-1" {
  vpc_id                  = aws_vpc.ebullion-vpc.id
  cidr_block              = var.private-1-cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.private-1-az
  tags = tomap({
    Name    = "${var.private-subnet-1-name}",
    ProvisioningVendor = "${var.vendor}",
    "kubernetes.io/role/internal-elb" = "1",
    "kubernetes.io/cluster/ebullion-non-prod-eks-cluster" = "shared"
  })
}


#PRIVATE SUBNET 2
resource "aws_subnet" "ebullion-private-subnet-2" {
  vpc_id                  = aws_vpc.ebullion-vpc.id
  cidr_block              = var.private-2-cidr
  map_public_ip_on_launch = "false"
  availability_zone       = var.private-2-az
  tags = tomap({
    Name    = "${var.private-subnet-2-name}",
    ProvisioningVendor = "${var.vendor}"
    "kubernetes.io/role/internal-elb" = "1",
    "kubernetes.io/cluster/ebullion-non-prod-eks-cluster" = "shared"
  })
}



#INTERNET GATEWAY
resource "aws_internet_gateway" "ebullion-igw" {
  vpc_id = aws_vpc.ebullion-vpc.id

  tags = tomap({
    Name    = "${var.igw-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}

#PUBLIC ROUTE TABLE 1
resource "aws_route_table" "ebullion-public-rt-1" {
  vpc_id = aws_vpc.ebullion-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ebullion-igw.id
  }

  tags = tomap({
    Name    = "${var.public-rt-1-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}

#PUBLIC ROUTE TABLE 2
resource "aws_route_table" "ebullion-public-rt-2" {
  vpc_id = aws_vpc.ebullion-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ebullion-igw.id
  }

  tags = tomap({
    Name    = "${var.public-rt-2-name}",
    ProvisioningVendor = "${var.vendor}"
  })
}


#ROUTE TABLE ASSOCIATION : PUBLIC 1
resource "aws_route_table_association" "ebullion-public-rt-1-association" {
  subnet_id      = aws_subnet.ebullion-public-subnet-1.id
  route_table_id = aws_route_table.ebullion-public-rt-1.id
}

#ROUTE TABLE ASSOCIATION : PUBLIC 2
resource "aws_route_table_association" "ebullion-public-rt-2-association" {
  subnet_id      = aws_subnet.ebullion-public-subnet-2.id
  route_table_id = aws_route_table.ebullion-public-rt-2.id
}
