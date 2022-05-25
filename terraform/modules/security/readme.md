<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.agent-pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.server-pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.agent-pods2cluster_DNS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster2agent-pods_ALL_TCP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster2efs_2049_TCP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.cluster2server-pods_ALL_TCP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server-pods2cluster_DNS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.server-pods2postgres_5432_TCP](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster. It's needed for shared networks label for EKS | `string` | n/a | yes |
| <a name="input_cluster_sg_id"></a> [cluster\_sg\_id](#input\_cluster\_sg\_id) | Cluster security group ID | `string` | n/a | yes |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | n/a | `map(any)` | `{}` | no |
| <a name="input_efs_sg_id"></a> [efs\_sg\_id](#input\_efs\_sg\_id) | EFS security group ID | `string` | n/a | yes |
| <a name="input_postgres_sg_id"></a> [postgres\_sg\_id](#input\_postgres\_sg\_id) | Database security group ID | `string` | n/a | yes |
| <a name="input_stage_tag"></a> [stage\_tag](#input\_stage\_tag) | The variable is used for the stage tag for all objects that will be created and for prefixes in the names | `string` | `"dev"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_pods_sg"></a> [agent\_pods\_sg](#output\_agent\_pods\_sg) | n/a |
| <a name="output_server_pods_sg"></a> [server\_pods\_sg](#output\_server\_pods\_sg) | n/a |
<!-- END_TF_DOCS -->