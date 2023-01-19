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
