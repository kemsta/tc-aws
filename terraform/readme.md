<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.10 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.5 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.11 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_application"></a> [application](#module\_application) | ./modules/application | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_security"></a> [security](#module\_security) | ./modules/security | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_coredns_version"></a> [coredns\_version](#input\_coredns\_version) | n/a | `string` | `"v1.8.4-eksbuild.1"` | no |
| <a name="input_db_allocated_storage"></a> [db\_allocated\_storage](#input\_db\_allocated\_storage) | Initial size for database storage | `number` | `20` | no |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | Version of database. To see available use aws rds describe-db-engine-versions --default-only --engine postgres | `string` | `"14.2"` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | Instance class for database | `string` | `"db.t3.micro"` | no |
| <a name="input_db_max_allocated_storage"></a> [db\_max\_allocated\_storage](#input\_db\_max\_allocated\_storage) | Maximum size for database storage | `number` | `100` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username | `string` | `"teamcity"` | no |
| <a name="input_ebs_csi_driver_version"></a> [ebs\_csi\_driver\_version](#input\_ebs\_csi\_driver\_version) | n/a | `string` | `"v1.6.1-eksbuild.1"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Root hostname for application | `string` | `"example.local"` | no |
| <a name="input_initialized"></a> [initialized](#input\_initialized) | Switch on after application initialization | `bool` | `false` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Instance types for kubernetes workers | `list(string)` | <pre>[<br>  "c5.large"<br>]</pre> | no |
| <a name="input_kube_proxy_version"></a> [kube\_proxy\_version](#input\_kube\_proxy\_version) | n/a | `string` | `"v1.21.2-eksbuild.2"` | no |
| <a name="input_kuber_version"></a> [kuber\_version](#input\_kuber\_version) | Kubernetes version for EKS cluster | `string` | `"1.21"` | no |
| <a name="input_max_azs"></a> [max\_azs](#input\_max\_azs) | The maximum number of available zones that will be created. The variable is used for CIDR blocks calculation | `number` | `2` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name where will be installed teamcity server and agents | `string` | `"teamcity"` | no |
| <a name="input_nodes_desired_size"></a> [nodes\_desired\_size](#input\_nodes\_desired\_size) | Desired size for autoscale node group | `number` | `2` | no |
| <a name="input_nodes_max_size"></a> [nodes\_max\_size](#input\_nodes\_max\_size) | Max size for autoscale node group | `number` | `4` | no |
| <a name="input_nodes_min_size"></a> [nodes\_min\_size](#input\_nodes\_min\_size) | Min size for autoscale node group | `number` | `2` | no |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_stage_tag"></a> [stage\_tag](#input\_stage\_tag) | The variable is used for the stage tag for all objects that will be created and for prefixes in the names | `string` | `"dev"` | no |
| <a name="input_vpc-cidr"></a> [vpc-cidr](#input\_vpc-cidr) | Base CIDR block which will be divided into subnet CIDR blocks (e.g. `10.0.0.0/16`) | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_cni_version"></a> [vpc\_cni\_version](#input\_vpc\_cni\_version) | n/a | `string` | `"v1.10.1-eksbuild.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_user_id"></a> [agent\_user\_id](#output\_agent\_user\_id) | n/a |
| <a name="output_agent_user_secret"></a> [agent\_user\_secret](#output\_agent\_user\_secret) | n/a |
| <a name="output_initialize"></a> [initialize](#output\_initialize) | n/a |
| <a name="output_s3_user_id"></a> [s3\_user\_id](#output\_s3\_user\_id) | n/a |
| <a name="output_s3_user_secret"></a> [s3\_user\_secret](#output\_s3\_user\_secret) | n/a |
<!-- END_TF_DOCS -->