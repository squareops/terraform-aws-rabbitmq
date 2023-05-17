## AWS RabbitMQ Terraform Module
![squareops_avatar]

[squareops_avatar]: https://squareops.com/wp-content/uploads/2022/12/squareops-logo.png

### [SquareOps Technologies](https://squareops.com/) Your DevOps Partner for Accelerating cloud journey.
<br>
We publish several terraform modules.
<br>
Terraform Module to create AWS AmazonMQ on AWS Cloud.

## Uses Example
```hcl
module "rabbitmq_broker" {
  source = "gitlab.com/sq-ia/aws/rabbitmq.git"
  environment                = "production"
  name                       = "skaf"
  vpc_id                     = "vpc-xyz5ed3skaf"
  username                   = "admin"
  subnet_ids                 = ["subnet-xyz355fskaf"]
  engine_version             = "3.10.20"
  storage_type               = "ebs"
  host_instance_type         = "mq.m5.large"
  deployment_mode            = "SINGLE_INSTANCE"
  apply_immediately          = true
  publicly_accessible        = false
  authentication_strategy    = "simple"
  allowed_security_groups    = ["sg-xyzf8bdc01fd9skaf"]
  auto_minor_version_upgrade = false
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
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.23 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.0.0 |

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
| <a name="input_name"></a> [name](#input\_name) | The name of the amazonmq cluster | `string` | `""` | no |
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

## Contribution & Issue Reporting

To contribute to a project, you can typically:

  1. Find the repository on a platform like GitHub
  2. Fork the repository to your own account
  3. Make changes to the code
  4. Submit a pull request to the original repository

To report an issue with a project:

  1. Check the repository's [issue tracker](https://github.com/squareops/terraform-aws-vpc/issues) on GitHub
  2. Search to see if the issue has already been reported
  3. If you can't find an answer to your question in the documentation or issue tracker, you can ask a question by creating a new issue. Be sure to provide enough context and details so others can understand your problem.
  4. Contributing to the project can be a great way to get involved and get help. The maintainers and other contributors may be more likely to help you if you're already making contributions to the project.

## Our Other Projects

We have a number of other projects that you might be interested in:

  1. [terraform-aws-vpc](https://github.com/squareops/terraform-aws-vpc): Terraform module to create Networking resources for workload deployment on AWS Cloud.

  2. [terraform-aws-keypair](https://github.com/squareops/terraform-aws-keypair): Terraform module which creates EC2 key pair on AWS. The private key will be stored on SSM.

     Follow Us:

     To stay updated on our projects and future release, follow us on
     [GitHub](https://github.com/squareops/),
     [LinkedIn](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/)

     By joining our both the [email](https://github.com/squareops) and [Slack community](https://github.com/squareops), you can benefit from the different ways in which we provide support. You can receive timely notifications and updates through email and engage in real-time conversations and discussions with other members through Slack. This combination of resources can help you stay informed, get help when you need it, and contribute to the project in a meaningful way.  

## Security, Validation and pull-requests
we have offered here high standard, quality code. Hence we are using several [pre-commit hooks](.pre-commit-config.yaml) and [GitHub Actions](https://gitlab.com/sq-ia/aws/eks/-/tree/v1.0.0#security-validation-and-pull-requests) as a workflow. So here we will create pull-requests to any branch and validate the request automatically using pre-commit tool.

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/).

## Support Us

To support a GitHub project by liking it, you can follow these steps:

  1. Visit the repository: Navigate to the GitHub repository.

  2. Click the "Star" [button](https://github.com/squareops/terraform-aws-vpc): On the repository page, you'll see a "Star" button in the upper right corner. Clicking on it will star the repository, indicating your support for the project.

  3. Optionally, you can also leave a comment on the repository or open an issue to give feedback or suggest changes.

Starring a repository on GitHub is a simple way to show your support and appreciation for the project. It also helps to increase the visibility of the project and make it more discoverable to others.

## Who we are

We believe that the key to success in the digital age is the ability to deliver value quickly and reliably. That’s why we offer a comprehensive range of DevOps & Cloud services designed to help your organization optimize its systems & Processes for speed and agility.

  1. We are an AWS Advanced consulting partner which reflects our deep expertise in AWS Cloud and helping 100+ clients over the last 4 years.
  2. Expertise in Kubernetes and overall container solution helps companies expedite their journey by 10X.
  3. Infrastructure Automation is a key component to the success of our Clients and our Expertise helps deliver the same in the shortest time.
  4. DevSecOps as a service to implement security within the overall DevOps process and helping companies deploy securely and at speed.
  5. Platform engineering which supports scalable,Cost efficient infrastructure that supports rapid development, testing, and deployment.
  6. 24*7 SRE service to help you Monitor the state of your infrastructure and eradicate any issue within the SLA.

We provide [support](https://squareops.com/contact-us/) on all of our projects, no matter how small or large they may be.

You can find more information about our company on this [squareops.com](https://squareops.com/), follow us on [linkdin](https://www.linkedin.com/company/squareops-technologies-pvt-ltd/), or fill out a [job application](https://squareops.com/careers/). If you have any questions or would like assistance with your cloud strategy and implementation, please don't hesitate to [contact us](https://squareops.com/contact-us/).
