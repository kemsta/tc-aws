// network part
variable "vpc-cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`)"
}

variable "max_azs" {
  type        = number
  default     = 2
  description = "The maximum number of available zones that will be created. The variable is used for CIDR blocks calculation"
}

variable "stage_tag" {
  type        = string
  default     = "dev"
  description = "The variable is used for the stage tag for all objects that will be created and for prefixes in the names"
}

// storage part
variable "db_allocated_storage" {
  type        = number
  default     = 20
  description = "Initial size for database storage"
}

variable "db_max_allocated_storage" {
  type        = number
  default     = 100
  description = "Maximum size for database storage"
}

variable "db_engine_version" {
  type        = string
  default     = "14.2"
  description = "Version of database. To see available use aws rds describe-db-engine-versions --default-only --engine postgres"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Instance class for database"
}

// eks part

variable "kuber_version" {
  type        = string
  default     = "1.21"
  description = "Kubernetes version for EKS cluster"
}

variable "public_access_cidrs" {
  type        = string
  default     = "0.0.0.0/0"
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint"
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
