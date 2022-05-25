resource "aws_iam_role" "cluster" {
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
  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-cluster-iam-role"
  })
}

resource "aws_iam_role_policy_attachment" "this-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCCNIRole" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role_policy_attachment" "policyResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster.name
}

resource "aws_iam_role" "node" {
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
  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-node-iam-role"
  })
}

resource "aws_iam_policy" "efs_policy" {
  name = "AmazonEKS_EFS_CSI_Driver_Policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "ec2:DescribeAvailabilityZones"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "elasticfilesystem:CreateAccessPoint"
        ],
        Resource = "*",
        Condition = {
          StringLike = {
            "aws:RequestTag/efs.csi.aws.com/cluster" = "true"
          }
        }
      },
      {
        Effect   = "Allow",
        Action   = "elasticfilesystem:DeleteAccessPoint",
        Resource = "*",
        Condition = {
          StringEquals = {
            "aws:ResourceTag/efs.csi.aws.com/cluster" = "true"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_EFS_CSI_Driver_Policy" {
  policy_arn = aws_iam_policy.efs_policy.arn
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node.name
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node.name
}

resource "aws_iam_user" "agent_user" {
  name = "${var.stage_tag}-eks-agent-runner"

  tags = merge(var.default_tags, {
    Name : "${var.stage_tag}-eks-node-iam-role"
  })
}

resource "aws_iam_access_key" "agent_user_key" {
  user = aws_iam_user.agent_user.name
}

resource "aws_iam_policy" "agent_runner_policy" {
  name = "${var.stage_tag}-eks-agent-runner-policy"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeCluster",
          "eks:ListClusters"
        ],
        "Resource" : aws_eks_cluster.this.arn
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "agent_runner_policy_attach" {
  user       = aws_iam_user.agent_user.name
  policy_arn = aws_iam_policy.agent_runner_policy.arn
}

resource "kubernetes_config_map_v1_data" "aws-auth" {
  data = {
    "mapRoles" = <<EOT
- rolearn: ${aws_iam_role.node.arn}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
EOT
    "mapUsers" = <<EOT
- userarn: ${aws_iam_user.agent_user.arn}
  username: ${aws_iam_user.agent_user.name}
EOT
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  force = true
}