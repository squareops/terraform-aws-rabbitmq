locals {
  tags = {
    Environment = var.environment
  }
}

resource "random_password" "password" {
  length  = 16
  special = false
}

resource "aws_mq_broker" "amazonmq" {
  broker_name                = format("%s-%s-mq", var.environment, var.name)
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  storage_type               = var.storage_type
  host_instance_type         = var.host_instance_type
  authentication_strategy    = var.authentication_strategy
  deployment_mode            = var.deployment_mode
  apply_immediately          = var.apply_immediately
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  publicly_accessible        = var.publicly_accessible
  security_groups            = var.publicly_accessible ? null : [module.security_group_mq.security_group_id]
  subnet_ids                 = var.subnet_ids
  # TAGS TO BE ASSOCIATED WITH EACH RESOURCE

  tags = tomap(
    {
      "Name"        = format("%s-%s", var.environment, var.name)
      "Environment" = var.environment
    },
  )

  user {
    username = var.username
    password = random_password.password.result
  }

  maintenance_window_start_time {
    day_of_week = var.maintenance_window_start_time.day_of_week
    time_of_day = var.maintenance_window_start_time.time_of_day
    time_zone   = var.maintenance_window_start_time.time_zone
  }

}

resource "aws_security_group_rule" "default_ingress" {
  count = length(var.allowed_security_groups) > 0 ? length(var.allowed_security_groups) : 0

  description = "From allowed SGs"

  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = module.security_group_mq.security_group_id
}

resource "aws_security_group_rule" "cidr_ingress" {
  count = length(var.allowed_cidr_blocks) > 0 ? length(var.allowed_cidr_blocks) : 0

  description = "From allowed CIDRs"

  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = element(var.allowed_cidr_blocks, count.index)
  security_group_id = module.security_group_mq.security_group_id
}

resource "aws_security_group_rule" "https_ingress" {
  count = length(var.allowed_cidr_blocks) > 0 ? length(var.allowed_cidr_blocks) : 0

  description = "https access to rabbitmq from allowed security group."

  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = element(var.allowed_security_groups, count.index)
  security_group_id        = module.security_group_mq.security_group_id
}

module "security_group_mq" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "4.13.0"
  create      = true
  name        = format("%s-%s-%s", var.environment, var.name, "mq-sg")
  description = "Elastic-cache mq security group"
  vpc_id      = var.vpc_id

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.name, "mq-sg") },
    local.tags,
  )
}

resource "aws_secretsmanager_secret" "secret_mq" {
  name = format("%s/%s/%s", var.environment, var.name, "rabbitmq-pass")
  tags = merge(
    { "Name" = format("%s/%s/%s", var.environment, var.name, "rabbitmq-pass") },
    local.tags,
  )
  recovery_window_in_days = var.recovery_window_aws_secret
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret_mq.id
  secret_string = <<EOF
   {
    "username": "${var.username}",
    "password": "${random_password.password.result}"
   }
EOF
}

resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
  count               = var.cloudwatch_metric_alarms_enabled ? 1 : 0
  alarm_name          = format("%s-%s-%s", var.environment, var.name, "cpu-utilization")
  alarm_description   = "Rabbit MQ System CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "SystemCpuUtilization"
  namespace           = "AWS/AmazonMQ"
  period              = "300"
  statistic           = "Average"

  threshold = var.alarm_cpu_threshold_percent

  dimensions = {
    Broker = aws_mq_broker.amazonmq.broker_name
  }

  alarm_actions = [aws_sns_topic.slack_topic[0].arn]
  ok_actions    = [aws_sns_topic.slack_topic[0].arn]
  depends_on    = [aws_sns_topic.slack_topic]

  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.name, "system_cpu_utilization") },
    local.tags,
  )
}

resource "aws_cloudwatch_metric_alarm" "memory_used" {
  count               = var.cloudwatch_metric_alarms_enabled ? 1 : 0
  alarm_name          = format("%s-%s-%s", var.environment, var.name, "memory-used")
  alarm_description   = "Rabbit MQ Memory Used"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "RabbitMQMemUsed"
  namespace           = "AWS/AmazonMQ"
  period              = "300"
  statistic           = "Average"

  threshold = var.alarm_memory_used_threshold
  dimensions = {
    Broker = aws_mq_broker.amazonmq.broker_name
  }

  alarm_actions = [aws_sns_topic.slack_topic[0].arn]
  ok_actions    = [aws_sns_topic.slack_topic[0].arn]
  depends_on    = [aws_sns_topic.slack_topic]

  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.name, "system_cpu_utilization") },
    local.tags,
  )
}

resource "aws_kms_key" "this" {
  count       = var.slack_notification_enabled ? 1 : 0
  description = "KMS key for notify-slack test"
}

resource "aws_kms_ciphertext" "slack_url" {
  count     = var.slack_notification_enabled ? 1 : 0
  plaintext = var.slack_webhook_url
  key_id    = aws_kms_key.this[0].arn
}

resource "aws_sns_topic" "slack_topic" {
  count           = var.cloudwatch_metric_alarms_enabled ? 1 : 0
  depends_on      = [aws_mq_broker.amazonmq]
  name            = format("%s-%s-%s", var.environment, var.name, "slack-topic")
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

data "archive_file" "lambdazip" {
  count       = var.slack_notification_enabled ? 1 : 0
  type        = "zip"
  output_path = "${path.module}/lambda/sns_slack.zip"

  source_dir = "${path.module}/lambda/"
}


module "cw_sns_slack" {
  count  = var.slack_notification_enabled ? 1 : 0
  source = "./lambda"

  name          = format("%s-%s-%s", var.environment, var.name, "sns-slack")
  description   = "notify slack channel on sns topic"
  artifact_file = "${path.module}/lambda/sns_slack.zip"
  handler       = "sns_slack.lambda_handler"
  runtime       = "python3.8"
  memory_size   = 128
  timeout       = 30
  environment = {
    "SLACK_URL"     = var.slack_webhook_url
    "SLACK_CHANNEL" = var.slack_channel
    "SLACK_USER"    = var.slack_username
  }
  tags = merge(
    { "Name" = format("%s-%s-%s", var.environment, var.name, "lambda") },
    local.tags,
  )
}

resource "aws_sns_topic_subscription" "slack-endpoint" {
  count                  = var.slack_notification_enabled ? 1 : 0
  endpoint               = module.cw_sns_slack[0].arn
  protocol               = "lambda"
  endpoint_auto_confirms = true
  topic_arn              = aws_sns_topic.slack_topic[0].arn
}

resource "aws_lambda_permission" "sns_lambda_slack_invoke" {
  count         = var.slack_notification_enabled ? 1 : 0
  statement_id  = "sns_slackAllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.cw_sns_slack[0].arn
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack_topic[0].arn
}
