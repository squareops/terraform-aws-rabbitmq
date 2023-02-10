variable "name" {
  description = "The name of the amazonmq cluster"
  type        = string
  default     = ""
}

variable "environment" {
  description = "The name of environment"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks which are allowed to access the database"
  default     = []
  type        = list(any)
}

variable "allowed_security_groups" {
  description = "A list of Security Group ID's to allow access to"
  default     = []
  type        = list(any)
}

variable "port" {
  description = "The rabbit-mq cluster port number"
  default     = 5671
  type        = number
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "Subnet IDs in which to launch the broker.A SINGLE_INSTANCE deployment requires one subnet. An ACTIVE_STANDBY_MULTI_AZ deployment requires multiple subnets."

}

variable "host_instance_type" {
  type        = string
  default     = ""
  description = "(Required) Broker's instance type. For example, `mq.t3.micro`, `mq.m5.large`."
}

variable "engine_type" {
  type        = string
  description = "(optional) Type of broker engine."
  default     = "RabbitMQ"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "(optional) Version of the broker engine. See the [AmazonMQ Broker Engine docs](https://docs.aws.amazon.com/amazon-mq/latest/developer-guide/broker-engine.html) for supported versions."
}

variable "storage_type" {
  type        = string
  description = "(optional) Storage type of the broker, only ebs work with mq.m5.large"
  default     = null
}

variable "authentication_strategy" {
  type        = string
  description = "(optional) Authentication strategy used to secure the broker"
  default     = "simple"
}

variable "deployment_mode" {
  type        = string
  description = "(optional) description"
  default     = "SINGLE_INSTANCE"
}

variable "apply_immediately" {
  type        = bool
  description = "(Optional) Specifies whether any broker modifications are applied immediately, or during the next maintenance window."
  default     = true
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "(optional) Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available."
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = "(optional) Whether to enable connections from applications outside of the VPC that hosts the broker's subnets."
  default     = false
}

variable "username" {
  type        = string
  default     = ""
  description = "Username of the user"
}

variable "maintenance_window_start_time" {
  type = object({
    day_of_week = string
    time_of_day = string
    time_zone   = string
  })
  description = "Configuration block for the maintenance window start time."
  default = {
    day_of_week = "MONDAY"
    time_of_day = "22:45"
    time_zone   = "Europe/Berlin"
  }
}

variable "recovery_window_aws_secret" {
  default     = 0
  type        = number
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days."
}
