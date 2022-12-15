#1. CREATE IAM ROLE FOR WORKER NODES
resource "aws_iam_role" "iam-role-worker-node" {
  name = "iam-role-worker-node-pre-prod"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

#2. ATTACH IAM ROLE TO WORKER POLICIES
resource "aws_iam_role_policy_attachment" "eks-worker-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam-role-worker-node.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam-role-worker-node.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam-role-worker-node.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-SSM-Managed-Instance-core" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.iam-role-worker-node.name
}

#3. CREATE EKS NODEGROUP
resource "aws_eks_node_group" "eks-node-group-1" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node-group-1"
  node_role_arn   = aws_iam_role.iam-role-worker-node.arn
  subnet_ids = [aws_subnet.ebullion-private-subnet-1.id , aws_subnet.ebullion-private-subnet-2.id]
  instance_types = ["${var.node-instance-type}"]

  scaling_config {
    desired_size = var.desired-instance-count
    max_size     = var.max-instance-count
    min_size     = var.min-instance-count
  }
  tags = tomap({
    Name    = "${var.eks-nodes-name}",
    ProvisioningVendor = "${var.vendor}"
  })

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks-worker-node-SSM-Managed-Instance-core,
  ]
}



#3. CREATE EKS NODEGROUP
resource "aws_eks_node_group" "eks-node-group-2" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node-group-2"
  node_role_arn   = aws_iam_role.iam-role-worker-node.arn
  subnet_ids = [aws_subnet.ebullion-private-subnet-1.id , aws_subnet.ebullion-private-subnet-2.id]
  instance_types = ["${var.node-instance-type}"]

  scaling_config {
    desired_size = var.desired-instance-count
    max_size     = var.max-instance-count
    min_size     = var.min-instance-count
  }
  tags = tomap({
    Name    = "${var.eks-nodes-name}",
    ProvisioningVendor = "${var.vendor}"
  })

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-worker-node-AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks-worker-node-SSM-Managed-Instance-core,
  ]
}