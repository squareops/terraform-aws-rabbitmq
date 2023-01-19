## IAM Permission
<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Policy required is:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CreateNetworkInterface",
                "ec2:CreateNetworkInterfacePermission",
                "ec2:CreateSecurityGroup",
                "ec2:CreateTags",
                "ec2:DeleteNetworkInterface",
                "ec2:DeleteNetworkInterfacePermission",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteTags",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcs",
                "ec2:DetachNetworkInterface",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:RevokeSecurityGroupIngress"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "mq:CreateBroker",
                "mq:CreateTags",
                "mq:CreateUser",
                "mq:DeleteBroker",
                "mq:DeleteTags",
                "mq:DeleteUser",
                "mq:DescribeBroker",
                "mq:DescribeUser",
                "mq:UpdateBroker",
                "mq:UpdateUser"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:CreateSecret",
                "secretsmanager:DeleteSecret",
                "secretsmanager:DescribeSecret",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:PutSecretValue",
                "secretsmanager:TagResource",
                "secretsmanager:UntagResource"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.23 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_group_mq"></a> [security\_group\_mq](#module\_security\_group\_mq) | terraform-aws-modules/security-group/aws | 4.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_mq_broker.amazonmq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |
| [aws_secretsmanager_secret.secret_mq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group_rule.cidr_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of CIDR blocks which are allowed to access the database | `list(any)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | A list of Security Group ID's to allow access to | `list(any)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional) Specifies whether any broker modifications are applied immediately, or during the next maintenance window. | `bool` | `true` | no |
| <a name="input_authentication_strategy"></a> [authentication\_strategy](#input\_authentication\_strategy) | (optional) Authentication strategy used to secure the broker | `string` | `"simple"` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | (optional) Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available. | `bool` | `false` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | (optional) description | `string` | `"SINGLE_INSTANCE"` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | (optional) Type of broker engine. | `string` | `"RabbitMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (optional) Version of the broker engine. See the [AmazonMQ Broker Engine docs](https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html) for supported versions. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of environment | `string` | `""` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | (Required) Broker's instance type. For example, `mq.t3.micro`, `mq.m5.large`. | `string` | `""` | no |
| <a name="input_maintenance_window_start_time"></a> [maintenance\_window\_start\_time](#input\_maintenance\_window\_start\_time) | Configuration block for the maintenance window start time. | <pre>object({<br>    day_of_week = string<br>    time_of_day = string<br>    time_zone   = string<br>  })</pre> | <pre>{<br>  "day_of_week": "MONDAY",<br>  "time_of_day": "22:45",<br>  "time_zone": "Europe/Berlin"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the amazonmq cluster | `string` | `"us-east-1"` | no |
| <a name="input_port"></a> [port](#input\_port) | The rabbit-mq cluster port number | `number` | `5671` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | (optional) Whether to enable connections from applications outside of the VPC that hosts the broker's subnets. | `bool` | `false` | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. | `number` | `0` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | (optional) Storage type of the broker, only ebs work with mq.m5.large | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs in which to launch the broker.A SINGLE\_INSTANCE deployment requires one subnet. An ACTIVE\_STANDBY\_MULTI\_AZ deployment requires multiple subnets. | `list(string)` | `[]` | no |
| <a name="input_username"></a> [username](#input\_username) | Username of the user | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rabbitmq_broker_arn"></a> [rabbitmq\_broker\_arn](#output\_rabbitmq\_broker\_arn) | ARN of the RabbitMQ broker. |
| <a name="output_rabbitmq_broker_console_url"></a> [rabbitmq\_broker\_console\_url](#output\_rabbitmq\_broker\_console\_url) | The URL of the broker's RabbitMQ Web Console |
| <a name="output_rabbitmq_broker_endpoint"></a> [rabbitmq\_broker\_endpoint](#output\_rabbitmq\_broker\_endpoint) | Broker's wire-level protocol endpoint |
| <a name="output_rabbitmq_broker_id"></a> [rabbitmq\_broker\_id](#output\_rabbitmq\_broker\_id) | ID of the RabbitMQ broker. |
| <a name="output_rabbitmq_password"></a> [rabbitmq\_password](#output\_rabbitmq\_password) | The Rabbitmq password (this password may be old, because Terraform doesn't track it after initial creation) |
| <a name="output_rabbitmq_security_group"></a> [rabbitmq\_security\_group](#output\_rabbitmq\_security\_group) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
