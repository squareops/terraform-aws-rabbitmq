output "rabbitmq_broker_arn" {
  description = "ARN of the RabbitMQ broker."
  value       = aws_mq_broker.amazonmq.arn
}

output "rabbitmq_broker_id" {
  description = "ID of the RabbitMQ broker."
  value       = aws_mq_broker.amazonmq.id
}

output "rabbitmq_broker_console_url" {
  description = "The URL of the broker's RabbitMQ Web Console"
  value       = aws_mq_broker.amazonmq.instances[0].console_url
}

output "rabbitmq_broker_endpoint" {
  description = "Broker's wire-level protocol endpoint"
  value       = aws_mq_broker.amazonmq.instances[0].endpoints
}


output "rabbitmq_security_group" {
  description = "The security group ID of the cluster"
  value       = module.security_group_mq.security_group_id
}

output "rabbitmq_password" {
  description = "The Rabbitmq password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = nonsensitive(random_password.password.result)
}
