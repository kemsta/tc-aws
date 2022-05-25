variable "stage_tag" {
  type        = string
  default     = "dev"
  description = "The variable is used for the stage tag for all objects that will be created and for prefixes in the names"
}

variable "default_tags" {
  type    = map(any)
  default = {}
}

variable "private_networks" {
  type        = map(any)
  description = "Subnets where will be rolled up storages"
}

variable "vpc_id" {
  type = string
}

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

variable "db_username" {
  type        = string
  default     = "teamcity"
  description = "Database username"
}