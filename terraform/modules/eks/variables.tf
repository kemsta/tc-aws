variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster. It's needed for shared networks label for EKS"
}

variable "kuber_version" {
  type        = string
  default     = "1.21"
  description = "Kubernetes version for EKS cluster"
}

variable "public_networks" {
  type        = map(any)
  description = "Subnets where will be rolled up EKS master nodes"
}

variable "private_networks" {
  type        = map(any)
  description = "Subnets where will be rolled up EKS worker nodes"
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

variable "kube_proxy_version" {
  type    = string
  default = "v1.21.2-eksbuild.2"
}

variable "vpc_cni_version" {
  type    = string
  default = "v1.10.1-eksbuild.1"
}

variable "coredns_version" {
  type    = string
  default = "v1.8.4-eksbuild.1"
}

variable "ebs_csi_driver_version" {
  type    = string
  default = "v1.6.1-eksbuild.1"
}

variable "efs_id" {
  type        = string
  description = "Id of efs for shared storage class"
}

variable "stage_tag" {
  type        = string
  default     = "dev"
  description = "The variable is used for the stage tag for all objects that will be created and for prefixes in the names"
}

variable "public_access_cidrs" {
  type        = string
  default     = "0.0.0.0/0"
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint"
}