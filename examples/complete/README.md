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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rabbitmq"></a> [rabbitmq](#module\_rabbitmq) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_broker-arn"></a> [broker-arn](#output\_broker-arn) | ARN of the RabbitMQ broker. |
| <a name="output_broker-console_url"></a> [broker-console\_url](#output\_broker-console\_url) | The URL of the broker's RabbitMQ Web Console |
| <a name="output_broker-endpoint"></a> [broker-endpoint](#output\_broker-endpoint) | Broker's wire-level protocol endpoint |
| <a name="output_broker-id"></a> [broker-id](#output\_broker-id) | ID of the RabbitMQ broker. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
