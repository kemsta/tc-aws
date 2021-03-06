variable "stage_tag" {
  type        = string
  default     = "dev"
  description = "The variable is used for the stage tag for all objects that will be created and for prefixes in the names"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name where will be installed teamcity server and agents"
}

variable "namespace" {
  type        = string
  default     = "teamcity"
  description = "Namespace name where will be installed teamcity server and agents"
}

variable "server_pods_sg" {
  type        = string
  default     = ""
  description = "Server pods security group id"
}

variable "agent_pods_sg" {
  type        = string
  default     = ""
  description = "Agents pods security group id"
}

variable "hostname" {
  type        = string
  description = "Root hostname for application"
}

variable "initialized" {
  type        = bool
  default     = false
  description = "Switch on after application initialization"
}

variable "agent_user_arn" {
  type        = string
  description = "Agent user arn"
}

variable "agent_user_name" {
  type        = string
  description = "Agent user name"
}

variable "node_role_arn" {
  type        = string
  description = "Node role arn"
}