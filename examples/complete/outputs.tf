output "broker-arn" {
  description = "ARN of the RabbitMQ broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_arn
}

output "broker-id" {
  description = "ID of the RabbitMQ broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_id
}

output "broker-console_url" {
  description = "The URL of the broker's RabbitMQ Web Console"
  value       = module.rabbitmq_broker.rabbitmq_broker_console_url
}

output "broker-endpoint" {
  description = "Broker's wire-level protocol endpoint"
  value       = module.rabbitmq_broker.rabbitmq_broker_endpoint
}

output "security_group" {
  description = "The security group ID of the cluster"
  value       = module.rabbitmq_broker.rabbitmq_security_group
}

output "rabbitmq_password" {
  description = "The Rabbitmq password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.rabbitmq_broker.rabbitmq_password

}
