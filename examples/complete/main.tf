locals {
  name                    = "skaf"
  region                  = "us-east-1"
  environment             = "production"
  engine_version          = "3.10.20"
  host_instance_type      = "mq.m5.large"
  vpc_id                  = "vpc-069a755f3a7"
  subnet_ids              = ["subnet-0bb23128ab"]
  kms_key_arn             = "arn:aws:kms:us-east-1:2222222222:key/bcfdc1c5-241e467d90"
  allowed_security_groups = ["sg-0e8d8b08e40"]
}

module "rabbitmq_broker" {
  source                  = "git@github.com:sq-ia/terraform-aws-rabbitmq.git"
  name                    = local.name
  username                = "admin"
  storage_type            = "ebs"
  engine_version          = local.engine_version
  host_instance_type      = local.host_instance_type
  environment             = local.environment
  vpc_id                  = local.vpc_id
  subnet_ids              = local.subnet_ids
  deployment_mode         = "SINGLE_INSTANCE"
  apply_immediately       = true
  publicly_accessible     = false
  authentication_strategy = "simple"
  allowed_security_groups = local.allowed_security_groups
  maintenance_window_start_time = {
    day_of_week = "SUNDAY"
    time_of_day = "00:30"
    time_zone   = "GMT"
  }
}
