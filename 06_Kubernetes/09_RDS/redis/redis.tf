# Subnet group required by ElastiCache
resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "education-redis-subnets2"
  subnet_ids = data.aws_subnets.default.ids
}

# ElastiCache Redis Cluster
resource "aws_elasticache_cluster" "education_redis" {
  cluster_id           = "student-demo-redis2"
  engine               = "redis"
  node_type            = "cache.t3.micro" # Free-tier friendly
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids   = [aws_security_group.redis_sg.id]
}

