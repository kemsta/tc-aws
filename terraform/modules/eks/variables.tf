variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster. It's needed for shared networks label for EKS"
}

variable "cluster_role_arn" {
  type        = string
  description = "Arn for cluster role with AmazonEKSClusterPolicyt"
}

variable "kuber_version" {
  type        = string
  default     = "1.21"
  description = "Kubernetes version for EKS cluster"
}

variable "subnet_ids" {
  type        = list(any)
  description = "Subnets where will be rolled up EKS master nodes"
}

variable "security_group_ids" {
  type        = list(any)
  default     = []
  description = "Security groups for EKS cluster"
}
