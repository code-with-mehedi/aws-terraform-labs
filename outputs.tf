# ─────────────────────────────────────
# Networking Outputs
# ─────────────────────────────────────

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  description = "List of database subnet IDs"
  value       = module.vpc.database_subnet_ids
}

# ─────────────────────────────────────
# Load Balancer Outputs
# ─────────────────────────────────────

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

# ─────────────────────────────────────
# Database Outputs
# ─────────────────────────────────────

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.endpoint
}

# ─────────────────────────────────────
# Cache Outputs
# ─────────────────────────────────────

output "redis_endpoint" {
  description = "ElastiCache Redis endpoint"
  value       = module.elasticache.endpoint
}
