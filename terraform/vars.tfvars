coredns_version          = "v1.8.4-eksbuild.1"
db_allocated_storage     = 20
db_engine_version        = "14.2"
db_instance_class        = "db.t3.micro"
db_max_allocated_storage = 100
db_username              = "teamcity"
ebs_csi_driver_version   = "v1.6.1-eksbuild.1"
hostname                 = "example.local"
initialized              = false
instance_types = [
  "c5.large"
]
kube_proxy_version = "v1.21.2-eksbuild.2"
kuber_version      = "1.21"
max_azs            = 2
namespace          = "teamcity"
nodes_desired_size = 2
nodes_max_size     = 4
nodes_min_size     = 2
public_access_cidrs = [
  "0.0.0.0/0"
]
stage_tag       = "dev"
vpc-cidr        = "10.0.0.0/16"
vpc_cni_version = "v1.10.1-eksbuild.1"

<!-- BEGIN_TF_DOCS -->
coredns_version          = "v1.8.4-eksbuild.1"
db_allocated_storage     = 20
db_engine_version        = "14.2"
db_instance_class        = "db.t3.micro"
db_max_allocated_storage = 100
db_username              = "teamcity"
ebs_csi_driver_version   = "v1.6.1-eksbuild.1"
hostname                 = "example.local"
initialized              = false
instance_types = [
  "c5.large"
]
kube_proxy_version = "v1.21.2-eksbuild.2"
kuber_version      = "1.21"
max_azs            = 2
namespace          = "teamcity"
nodes_desired_size = 2
nodes_max_size     = 4
nodes_min_size     = 2
public_access_cidrs = [
  "0.0.0.0/0"
]
stage_tag       = "dev"
vpc-cidr        = "10.0.0.0/16"
vpc_cni_version = "v1.10.1-eksbuild.1"
<!-- END_TF_DOCS -->