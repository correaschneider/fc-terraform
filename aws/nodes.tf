resource "aws_iam_role" "new-node-iam" {
  name = "${var.prefix}-${var.cluster_name}-node-role"
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

resource "aws_iam_role_policy_attachment" "new-node-AmazonEKSWorkerNodePolicy" {
  role = aws_iam_role.new-node-iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "new-node-AmazonEKS_CNI_Policy" {
  role = aws_iam_role.new-node-iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "new-node-AmazonEC2ContainerRegistryReadOnly" {
  role = aws_iam_role.new-node-iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "new-node-1" {
  node_role_arn = aws_iam_role.new-node-iam.arn
  cluster_name = aws_eks_cluster.new-cluster.name
  node_group_name = "${var.prefix}-node-1"
  subnet_ids = aws_subnet.subnets[*].id

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = ["t3.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.new-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.new-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.new-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "new-node-2" {
  node_role_arn = aws_iam_role.new-node-iam.arn
  cluster_name = aws_eks_cluster.new-cluster.name
  node_group_name = "${var.prefix}-node-2"
  subnet_ids = aws_subnet.subnets[*].id

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = ["t2.micro"]

  depends_on = [
    aws_iam_role_policy_attachment.new-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.new-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.new-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}