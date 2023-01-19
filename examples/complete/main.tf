provider "aws" {
  region = local.region
}

locals {
  name        = "complete-rabbitmq"
  region      = "us-east-1"
  environment = "dev"
}

module "rabbitmq" {
  source = "../../"

  environment = local.environment
  name        = local.name
  region      = local.region

  engine_type        = "RabbitMQ"
  engine_version     = "3.8.23"
  storage_type       = "ebs"
  host_instance_type = "mq.t3.micro"
  deployment_mode    = "SINGLE_INSTANCE"
  apply_immediately  = true
  vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
  port               = 5671
  username           = "ExampleUser"
}
