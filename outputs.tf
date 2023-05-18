output "rabbitmq_broker_arn" {
  description = "The Amazon Resource Name (ARN) of the RabbitMQ broker."
  value       = aws_mq_broker.amazonmq.arn
}

output "rabbitmq_broker_id" {
  description = "The unique identifier of the RabbitMQ broker."
  value       = aws_mq_broker.amazonmq.id
}

output "rabbitmq_broker_console_url" {
  description = "The URL of the RabbitMQ Web Console for managing the broker."
  value       = aws_mq_broker.amazonmq.instances[0].console_url
}

output "rabbitmq_broker_endpoint" {
  description = "The wire-level protocol endpoint of the RabbitMQ broker."
  value       = aws_mq_broker.amazonmq.instances[0].endpoints
}


output "rabbitmq_security_group" {
  description = "The security group ID associated with the RabbitMQ cluster."
  value       = module.security_group_mq.security_group_id
}

output "rabbitmq_password" {
  description = "The password for accessing the RabbitMQ cluster. Note that Terraform does not track this password after initial creation."
  value       = nonsensitive(random_password.password.result)
}
