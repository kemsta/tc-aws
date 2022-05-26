<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.teamcity](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map_v1_data.aws-auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map_v1_data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_pods_sg"></a> [agent\_pods\_sg](#input\_agent\_pods\_sg) | Agents pods security group id | `string` | `""` | no |
| <a name="input_agent_user_arn"></a> [agent\_user\_arn](#input\_agent\_user\_arn) | Agent user arn | `string` | n/a | yes |
| <a name="input_agent_user_name"></a> [agent\_user\_name](#input\_agent\_user\_name) | Agent user name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name where will be installed teamcity server and agents | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Root hostname for application | `string` | n/a | yes |
| <a name="input_initialized"></a> [initialized](#input\_initialized) | Switch on after application initialization | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name where will be installed teamcity server and agents | `string` | `"teamcity"` | no |
| <a name="input_node_role_arn"></a> [node\_role\_arn](#input\_node\_role\_arn) | Node role arn | `string` | n/a | yes |
| <a name="input_server_pods_sg"></a> [server\_pods\_sg](#input\_server\_pods\_sg) | Server pods security group id | `string` | `""` | no |
| <a name="input_stage_tag"></a> [stage\_tag](#input\_stage\_tag) | The variable is used for the stage tag for all objects that will be created and for prefixes in the names | `string` | `"dev"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->