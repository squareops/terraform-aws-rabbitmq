variable "name" {
  description = "The name of the Amazon MQ cluster. It provides a unique identifier for the cluster."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The name of the environment where the Amazon MQ cluster is deployed."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The ID of the VPC where the Amazon MQ cluster will be created."
  type        = string
  default     = ""
}

variable "allowed_cidr_blocks" {
  description = "A list of CIDR blocks that are allowed to access the Amazon MQ cluster."
  default     = []
  type        = list(any)
}

variable "allowed_security_groups" {
  description = "A list of Security Group IDs that are allowed to access the Amazon MQ cluster."
  default     = []
  type        = list(any)
}

variable "port" {
  description = "The port number on which the RabbitMQ cluster will be accessible."
  default     = 5671
  type        = number
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "The IDs of the subnets in which the Amazon MQ broker will be launched. "

}

variable "host_instance_type" {
  type        = string
  default     = ""
  description = "The instance type of the Amazon MQ broker. For example, 'mq.t3.micro' or 'mq.m5.large'."
}

variable "engine_type" {
  type        = string
  description = "The type of broker engine used in the Amazon MQ cluster."
  default     = "RabbitMQ"
}

variable "engine_version" {
  type        = string
  default     = ""
  description = "The version of the broker engine used in the Amazon MQ cluster."
}

variable "storage_type" {
  type        = string
  description = "(optional) Storage type of the broker, only ebs work with mq.m5.large"
  default     = null
}

variable "authentication_strategy" {
  type        = string
  description = "The authentication strategy used to secure the broker."
  default     = "simple"
}

variable "deployment_mode" {
  type        = string
  description = "The deployment mode of the Amazon MQ cluster."
  default     = "SINGLE_INSTANCE"
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any broker modifications are applied immediately or during the next maintenance window."
  default     = true
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Whether to automatically upgrade to new minor versions of brokers as Amazon MQ makes releases available."
  default     = false
}

variable "publicly_accessible" {
  type        = bool
  description = "Whether to enable connections from applications outside of the VPC that hosts the broker's subnets"
  default     = false
}

variable "username" {
  type        = string
  default     = ""
  description = "The username of the user for authentication."
}

variable "maintenance_window_start_time" {
  type = object({
    day_of_week = string
    time_of_day = string
    time_zone   = string
  })
  description = "The configuration block for the maintenance window start time."
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

variable "alarm_memory_used_threshold" {
  type        = string
  default     = "1000000000" // 1 GB
  description = "Alarm threshold for the 'lowFreeStorageSpace' alarm"
}

variable "cloudwatch_metric_alarms_enabled" {
  type        = bool
  description = "Boolean flag to enable/disable CloudWatch metrics alarms"
  default     = false
}

variable "alarm_cpu_threshold_percent" {
  type        = number
  default     = 75
  description = "CPU threshold alarm level"
}

variable "alarm_actions" {
  type        = list(string)
  description = "Alarm action list"
  default     = []
}

variable "ok_actions" {
  type        = list(string)
  description = "The list of actions to execute when this alarm transitions into an OK state from any other state. Each action is specified as an Amazon Resource Number (ARN)"
  default     = []
}

variable "slack_notification_enabled" {
  type        = bool
  description = "Whether to enable/disable slack notification."
  default     = false
}

variable "slack_webhook_url" {
  description = "The Slack Webhook URL where notifications will be sent."
  default     = ""
  type        = string
}

variable "slack_channel" {
  description = "The Slack channel where notifications will be posted."
  default     = ""
  type        = string
}

variable "slack_username" {
  description = "The username to use when sending notifications to Slack."
  default     = ""
  type        = string
}

variable "cw_sns_topic_arn" {
  description = "The username to use when sending notifications to Slack."
  default     = ""
  type        = string
}
