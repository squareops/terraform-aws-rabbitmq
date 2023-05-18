## RabbitMQ Example
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>

This example will be very useful for users who are new to a module and want to quickly learn how to use it. By reviewing the examples, users can gain a better understanding of how the module works, what features it supports, and how to customize it to their specific needs.

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
| <a name="module_rabbitmq_broker"></a> [rabbitmq\_broker](#module\_rabbitmq\_broker) | git@github.com:sq-ia/terraform-aws-rabbitmq.git | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_broker-arn"></a> [broker-arn](#output\_broker-arn) | The Amazon Resource Name (ARN) of the RabbitMQ broker. |
| <a name="output_broker-console_url"></a> [broker-console\_url](#output\_broker-console\_url) | The URL of the RabbitMQ Web Console for managing the broker. |
| <a name="output_broker-endpoint"></a> [broker-endpoint](#output\_broker-endpoint) | The wire-level protocol endpoint of the RabbitMQ broker. |
| <a name="output_broker-id"></a> [broker-id](#output\_broker-id) | The unique identifier of the RabbitMQ broker. |
| <a name="output_rabbitmq_password"></a> [rabbitmq\_password](#output\_rabbitmq\_password) | The password for accessing the RabbitMQ cluster. Note that Terraform does not track this password after initial creation. |
| <a name="output_security_group"></a> [security\_group](#output\_security\_group) | The security group ID associated with the RabbitMQ cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
