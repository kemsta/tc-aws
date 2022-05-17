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

variable "node_role_arn" {
  type        = string
  description = "Arn for cluster role with AmazonEKSClusterPolicyt"
}

variable "kuber_version" {
  type        = string
  default     = "1.21"
  description = "Kubernetes version for EKS cluster"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Subnets where will be rolled up EKS master nodes"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Subnets where will be rolled up EKS worker nodes"
}


variable "eks_workers_agents_sg_ids" {
  type        = list(string)
  description = "Security groups for agents workers"
}

variable "eks_control_plane_sg_ids" {
  type        = list(string)
  description = "Security groups for control plane"
}

variable "instance_types" {
  type        = list(string)
  default     = ["c5.large"]
  description = "Instance types for kubernetes workers"
}

variable "nodes_desired_size" {
  type        = number
  default     = 2
  description = "Desired size for autoscale node group"
}

variable "nodes_min_size" {
  type        = number
  default     = 2
  description = "Min size for autoscale node group"
}

variable "nodes_max_size" {
  type        = number
  default     = 4
  description = "Max size for autoscale node group"
}