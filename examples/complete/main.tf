locals {
  name        = "skaf"
  region      = "us-east-2"
  environment = "production"
}

module "rabbitmq_broker" {
  source = "../../"
  environment = local.environment
  name        = local.name
  engine_type                = "RabbitMQ"
  engine_version             = "3.8.23"
  storage_type               = "ebs"
  host_instance_type         = "mq.m5.large"
  authentication_strategy    = "simple"
  deployment_mode            = "SINGLE_INSTANCE"
  apply_immediately          = true
  auto_minor_version_upgrade = false
  publicly_accessible        = false
  vpc_id                     = "vpc-xyz5ed733e273skaf"
  subnet_ids                 = ["subnet-xyz35ec60335fskaf"]
  allowed_cidr_blocks        = []
  allowed_security_groups    = ["sg-xyzf8bdc01fd9skaf"]
  port                       = 5671
  username                   = "admin"
  maintenance_window_start_time = {
    day_of_week = "SUNDAY"
    time_of_day = "00:30"
    time_zone   = "GMT"
  }
}
