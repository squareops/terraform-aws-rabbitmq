locals {
  name                    = "skaf"
  region                  = ""
  environment             = "production"
  engine_version          = "3.10.20"
  host_instance_type      = "mq.m5.large"
  vpc_id                  = "vpc-074713b4396150ec8"
  subnet_ids              = ["subnet-0ba8240c1d81a77d3"]
  kms_key_arn             = ""
  allowed_security_groups = ["sg-00489964279928181"]
}

module "rabbitmq_broker" {
  source                           = "squareops/rabbitmq/aws"
  version                          = "2.1.2"
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
