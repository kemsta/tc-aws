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