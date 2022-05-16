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

variable "kuber_version" {
  type        = string
  default     = "1.21"
  description = "Kubernetes version for EKS cluster"
}