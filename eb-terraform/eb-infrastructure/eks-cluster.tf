#1. IAM CLUSTER ROLE
resource "aws_iam_role" "eks-iam-cluster-role" {
  name = "eks-iam-cluster-role-pre-prod"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#2. Attach IAM Role to Policy
resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-iam-cluster-role.name
}

#2.1. Attach IAM Role to Policy
resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-iam-cluster-role.name
}

#3. Create AWS SECURITY GROUP
resource "aws_security_group" "eks-cluster-security-group" {
  name        = "eks-cluster-security-group"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.ebullion-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }  

  tags = {
    Name = "eks-cluster-security-group"
  }
}


#4. CREATE EKS CLUSTER
resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.eks-iam-cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks-cluster-security-group.id]
    subnet_ids = [ aws_subnet.ebullion-public-subnet-1.id , aws_subnet.ebullion-public-subnet-2.id ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSVPCResourceController,
  ]
}
