output "broker-arn" {
  description = "ARN of the RabbitMQ broker."
  value       = module.rabbitmq.broker-arn
}

output "broker-id" {
  description = "ID of the RabbitMQ broker."
  value       = module.rabbitmq.broker-id
}

output "broker-console_url" {
  description = "The URL of the broker's RabbitMQ Web Console"
  value       = module.rabbitmq.broker-console_url
}

output "broker-endpoint" {
  description = "Broker's wire-level protocol endpoint"
  value       = module.rabbitmq.broker-endpoint
}
