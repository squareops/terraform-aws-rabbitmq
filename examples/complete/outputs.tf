output "broker-arn" {
  description = "The Amazon Resource Name (ARN) of the RabbitMQ broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_arn
}

output "broker-id" {
  description = "The unique identifier of the RabbitMQ broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_id
}

output "broker-console_url" {
  description = "The URL of the RabbitMQ Web Console for managing the broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_console_url
}

output "broker-endpoint" {
  description = "The wire-level protocol endpoint of the RabbitMQ broker."
  value       = module.rabbitmq_broker.rabbitmq_broker_endpoint
}

output "security_group" {
  description = "The security group ID associated with the RabbitMQ cluster."
  value       = module.rabbitmq_broker.rabbitmq_security_group
}

output "rabbitmq_password" {
  description = "The password for accessing the RabbitMQ cluster. Note that Terraform does not track this password after initial creation."
  value       = module.rabbitmq_broker.rabbitmq_password

}
