variable "stage_tag" {
  type        = string
  default     = "dev"
  description = "The variable is used for the stage tag for all objects that will be created and for prefixes in the names"
}

variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster. It's needed for shared networks label for EKS"
}

variable "vpc_id" {
  type = string
}

variable "cluster_sg_id" {
  type        = string
  description = "Cluster security group ID" // https://docs.aws.amazon.com/eks/latest/userguide/sec-group-reqs.html#cluster-sg
}

variable "postgres_sg_id" {
  type        = string
  description = "Database security group ID"
}

variable "efs_sg_id" {
  type        = string
  description = "EFS security group ID"
}