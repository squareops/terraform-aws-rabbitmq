## AWS RabbitMQ Terraform Module
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
This module provides an easy and efficient way to provision and manage RabbitMQ clusters on AWS. It simplifies the process of creating highly available and scalable RabbitMQ infrastructures by automating the deployment and configuration tasks.
Features

  1. Easy Configuration: The module allows you to define your RabbitMQ clusters and related resources using a concise and declarative syntax.

  2. High Availability: It supports the creation of RabbitMQ clusters with multiple nodes distributed across availability zones, ensuring fault tolerance and high availability.

  3. Security: The module integrates with AWS security features, allowing you to define security groups and control access to your RabbitMQ clusters.

  4. Scalability: You can easily scale your RabbitMQ clusters up or down by adjusting the number of nodes and instance types.

  5. Monitoring and Alerting: It provides integration with CloudWatch, enabling you to monitor key metrics and set up alerts for your RabbitMQ clusters.

  6. Logging: The module supports logging of RabbitMQ server logs to CloudWatch Logs or other specified destinations.

  7. Maintenance: You can configure maintenance windows for your RabbitMQ clusters to control the timing of maintenance activities.

  8. Secrets Management: The module supports the use of AWS Secrets Manager to securely store and manage RabbitMQ credentials.

  9. Customization: It offers a wide range of customizable parameters, allowing you to tailor the RabbitMQ configuration to your specific needs.

  10. CloudWatch Alerts: Set up CloudWatch alarms to monitor the health and performance of your Redis cluster. Integrate these alarms with AWS Simple Notification Service (SNS) to receive real-time alerts. Use AWS Lambda functions to customize your alerting logic, and send notifications to Slack channels for immediate visibility into your AWS RabbitMQ status.

## Uses Example
```hcl
module "rabbitmq_broker" {
  source                           =  "squareops/rabbitmq/kubernetes"
  version                          = "2.1.1"
  name                             = local.name
  username                         = "admin"
  storage_type                     = "ebs"
  engine_version                   = local.engine_version
  host_instance_type               = local.host_instance_type
  environment                      = local.environment
  vpc_id                           = local.vpc_id
  subnet_ids                       = local.subnet_ids
  deployment_mode                  = "SINGLE_INSTANCE"
  apply_immediately                = true
  publicly_accessible              = false
  authentication_strategy          = "simple"
  allowed_security_groups          = local.allowed_security_groups
  cloudwatch_metric_alarms_enabled = true
  alarm_cpu_threshold_percent      = 70
  alarm_memory_used_threshold      = "10000000" # in bytes
  slack_notification_enabled       = false
  slack_username                   = ""
  slack_channel                    = ""
  slack_webhook_url                = "https://hooks.slack.com/services/xxxxxxxxx"
  maintenance_window_start_time = {
    day_of_week = "SUNDAY"
    time_of_day = "00:30"
    time_zone   = "GMT"
  }
}


```
## Important Notes
1. This module permit safety institution regulations to permit access to the broker.
2. By default, the variable create_random_password is set to true. Therefore, even if the user provides a password, it will not be read. The create_random_password variable should be set to false and the password variable should have a non-null value to be read and used.

<!-- ## Security & Compliance [<img src="	https://prowler.pro/wp-content/themes/prowler-pro/assets/img/logo.svg" width="250" align="right" />](https://prowler.pro/)

Security scanning is graciously provided by Prowler. Proowler is the leading fully hosted, cloud-native solution providing continuous cluster security and compliance.

| Benchmark | Description |
|--------|---------------|
| Ensure that encryption is enabled for RDS instances | Enabled for RDS created using this module. | -->

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.23 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.23 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cw_sns_slack"></a> [cw\_sns\_slack](#module\_cw\_sns\_slack) | ./lambda | n/a |
| <a name="module_security_group_mq"></a> [security\_group\_mq](#module\_security\_group\_mq) | terraform-aws-modules/security-group/aws | 4.13.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cache_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_used](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_kms_ciphertext.slack_url](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_ciphertext) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_lambda_permission.sns_lambda_slack_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_mq_broker.amazonmq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |
| [aws_secretsmanager_secret.secret_mq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group_rule.cidr_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.default_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_sns_topic.slack_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.slack-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [archive_file.lambdazip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_actions"></a> [alarm\_actions](#input\_alarm\_actions) | Alarm action list | `list(string)` | `[]` | no |
| <a name="input_alarm_cpu_threshold_percent"></a> [alarm\_cpu\_threshold\_percent](#input\_alarm\_cpu\_threshold\_percent) | CPU threshold alarm level | `number` | `75` | no |
| <a name="input_alarm_memory_used_threshold"></a> [alarm\_memory\_used\_threshold](#input\_alarm\_memory\_used\_threshold) | Alarm threshold for the 'lowFreeStorageSpace' alarm | `string` | `"1000000000"` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | A list of CIDR blocks that are allowed to access the Amazon MQ cluster. | `list(any)` | `[]` | no |
| <a name="input_allowed_security_groups"></a> [allowed\_security\_groups](#input\_allowed\_security\_groups) | A list of Security Group IDs that are allowed to access the Amazon MQ cluster. | `list(any)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any broker modifications are applied immediately or during the next maintenance window. | `bool` | `true` | no |
| <a name="input_authentication_strategy"></a> [authentication\_strategy](#input\_authentication\_strategy) | The authentication strategy used to secure the broker. | `string` | `"simple"` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available. | `bool` | `false` | no |
| <a name="input_cloudwatch_metric_alarms_enabled"></a> [cloudwatch\_metric\_alarms\_enabled](#input\_cloudwatch\_metric\_alarms\_enabled) | Boolean flag to enable/disable CloudWatch metrics alarms | `bool` | `false` | no |
| <a name="input_cw_sns_topic_arn"></a> [cw\_sns\_topic\_arn](#input\_cw\_sns\_topic\_arn) | The username to use when sending notifications to Slack. | `string` | `""` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | The deployment mode of the Amazon MQ cluster. | `string` | `"SINGLE_INSTANCE"` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | The type of broker engine used in the Amazon MQ cluster. | `string` | `"RabbitMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the broker engine used in the Amazon MQ cluster. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the environment where the Amazon MQ cluster is deployed. | `string` | `""` | no |
| <a name="input_host_instance_type"></a> [host\_instance\_type](#input\_host\_instance\_type) | The instance type of the Amazon MQ broker. For example, 'mq.t3.micro' or 'mq.m5.large'. | `string` | `""` | no |
| <a name="input_maintenance_window_start_time"></a> [maintenance\_window\_start\_time](#input\_maintenance\_window\_start\_time) | The configuration block for the maintenance window start time. | <pre>object({<br>    day_of_week = string<br>    time_of_day = string<br>    time_zone   = string<br>  })</pre> | <pre>{<br>  "day_of_week": "MONDAY",<br>  "time_of_day": "22:45",<br>  "time_zone": "Europe/Berlin"<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Amazon MQ cluster. It provides a unique identifier for the cluster. | `string` | `""` | no |
| <a name="input_ok_actions"></a> [ok\_actions](#input\_ok\_actions) | The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN) | `list(string)` | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which the RabbitMQ cluster will be accessible. | `number` | `5671` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | Whether to enable connections from applications outside of the VPC that hosts the broker's subnets | `bool` | `false` | no |
| <a name="input_recovery_window_aws_secret"></a> [recovery\_window\_aws\_secret](#input\_recovery\_window\_aws\_secret) | Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. | `number` | `0` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The Slack channel where notifications will be posted. | `string` | `""` | no |
| <a name="input_slack_notification_enabled"></a> [slack\_notification\_enabled](#input\_slack\_notification\_enabled) | Whether to enable/disable slack notification. | `bool` | `false` | no |
| <a name="input_slack_username"></a> [slack\_username](#input\_slack\_username) | The username to use when sending notifications to Slack. | `string` | `""` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | The Slack Webhook URL where notifications will be sent. | `string` | `""` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | (optional) Storage type of the broker, only ebs work with mq.m5.large | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The IDs of the subnets in which the Amazon MQ broker will be launched. | `list(string)` | `[]` | no |
| <a name="input_username"></a> [username](#input\_username) | The username of the user for authentication. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the Amazon MQ cluster will be created. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rabbitmq_broker_arn"></a> [rabbitmq\_broker\_arn](#output\_rabbitmq\_broker\_arn) | The Amazon Resource Name (ARN) of the RabbitMQ broker. |
| <a name="output_rabbitmq_broker_console_url"></a> [rabbitmq\_broker\_console\_url](#output\_rabbitmq\_broker\_console\_url) | The URL of the RabbitMQ Web Console for managing the broker. |
| <a name="output_rabbitmq_broker_endpoint"></a> [rabbitmq\_broker\_endpoint](#output\_rabbitmq\_broker\_endpoint) | The wire-level protocol endpoint of the RabbitMQ broker. |
| <a name="output_rabbitmq_broker_id"></a> [rabbitmq\_broker\_id](#output\_rabbitmq\_broker\_id) | The unique identifier of the RabbitMQ broker. |
| <a name="output_rabbitmq_password"></a> [rabbitmq\_password](#output\_rabbitmq\_password) | The password for accessing the RabbitMQ cluster. Note that Terraform does not track this password after initial creation. |
| <a name="output_rabbitmq_security_group"></a> [rabbitmq\_security\_group](#output\_rabbitmq\_security\_group) | The security group ID associated with the RabbitMQ cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contribute & Issue Report

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/sq-ia/terraform-aws-rabbitmq/issues) on GitHub
  2. Search to check if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Make sure to provide enough context and details.

## License

Apache License, Version 2.0, January 2004 (https://www.apache.org/licenses/LICENSE-2.0)

## Support Us

To support our GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the [GitHub repository](https://github.com/sq-ia/terraform-aws-rabbitmq)

  2. Click the "Star" button: On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Staring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 5 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

To find more information about our company, visit [squareops.com](https://squareops.com/), follow us on [Linkedin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
