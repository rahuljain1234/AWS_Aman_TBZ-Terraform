output "cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "ECS Service Name"
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "Task Definition ARN"
  value       = aws_ecs_task_definition.this.arn
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.this.dns_name
}

output "service_urls" {
  description = "Service URLs created"
  value       = var.service_urls
}

output "ecr_repository_urls" {
  description = "Map of ECR Repository URLs"
  value       = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}
