# The endpoint used to connect to Redis
output "redis_endpoint" {
  value       = aws_elasticache_cluster.education_redis.cache_nodes[0].address
  description = "Redis connection endpoint (Internal VPC only)"
}

output "bastion_public_ip" {
  value       = aws_instance.bastion2.public_ip
  description = "Public IP of the Bastion Host to connect via SSH"
}