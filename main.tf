# ══════════════════════════════════════════════════
# AWS Terraform Labs — Final Project
# Production-Grade Multi-Tier Architecture
# ══════════════════════════════════════════════════
#
# Usage:
#   terraform apply -var-file="environments/dev/terraform.tfvars"
#   terraform apply -var-file="environments/prod/terraform.tfvars"
#

# ─────────────────────────────────────
# 1. Networking — VPC, Subnets, NAT, Routes
# ─────────────────────────────────────

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  environment           = var.environment
  project_name          = var.project_name
}

# ─────────────────────────────────────
# 2. Security Groups — ALB, Web, App, DB, Bastion
# ─────────────────────────────────────

module "security_groups" {
  source = "./modules/security-groups"

  vpc_id       = module.vpc.vpc_id
  vpc_cidr     = var.vpc_cidr
  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 3. IAM — Roles, Policies, Instance Profiles
# ─────────────────────────────────────

module "iam" {
  source = "./modules/iam"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 4. S3 — Application Buckets
# ─────────────────────────────────────

module "s3" {
  source = "./modules/s3"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 5. Secrets — Secrets Manager + KMS
# ─────────────────────────────────────

module "secrets" {
  source = "./modules/secrets"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 6. ALB — Application Load Balancer
# ─────────────────────────────────────

module "alb" {
  source = "./modules/alb"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  alb_security_group = module.security_groups.alb_sg_id
  environment        = var.environment
  project_name       = var.project_name
}

# ─────────────────────────────────────
# 7. EC2 — Web/App Instances
# ─────────────────────────────────────

module "ec2" {
  source = "./modules/ec2"

  instance_type      = var.instance_type
  key_name           = var.key_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.web_sg_id]
  instance_profile   = module.iam.instance_profile_name
  environment        = var.environment
  project_name       = var.project_name
}

# ─────────────────────────────────────
# 8. Auto Scaling — Launch Template + ASG
# ─────────────────────────────────────

module "auto_scaling" {
  source = "./modules/auto-scaling"

  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_ids           = module.vpc.private_subnet_ids
  security_group_ids   = [module.security_groups.web_sg_id]
  target_group_arns    = module.alb.target_group_arns
  instance_profile_arn = module.iam.instance_profile_arn
  environment          = var.environment
  project_name         = var.project_name
}

# ─────────────────────────────────────
# 9. RDS — Relational Database
# ─────────────────────────────────────

module "rds" {
  source = "./modules/rds"

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  db_name           = var.db_name
  username          = var.db_username
  subnet_ids        = module.vpc.database_subnet_ids
  security_group_id = module.security_groups.db_sg_id
  environment       = var.environment
  project_name      = var.project_name
}

# ─────────────────────────────────────
# 10. ElastiCache — Redis
# ─────────────────────────────────────

module "elasticache" {
  source = "./modules/elasticache"

  node_type         = var.cache_node_type
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.app_sg_id
  environment       = var.environment
  project_name      = var.project_name
}

# ─────────────────────────────────────
# 11. ECR — Container Registry
# ─────────────────────────────────────

module "ecr" {
  source = "./modules/ecr"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 12. ECS — Container Service (Fargate)
# ─────────────────────────────────────

module "ecs" {
  source = "./modules/ecs"

  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.app_sg_id]
  target_group_arn   = module.alb.target_group_arns
  execution_role_arn = module.iam.ecs_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  environment        = var.environment
  project_name       = var.project_name
}

# ─────────────────────────────────────
# 13. CloudWatch — Logs, Alarms, Dashboards
# ─────────────────────────────────────

module "cloudwatch" {
  source = "./modules/cloudwatch"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 14. SNS — Alerting Topics
# ─────────────────────────────────────

module "sns" {
  source = "./modules/sns"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 15. SQS — Message Queues
# ─────────────────────────────────────

module "sqs" {
  source = "./modules/sqs"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 16. Lambda — Serverless Functions
# ─────────────────────────────────────

module "lambda" {
  source = "./modules/lambda"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 17. API Gateway — REST/HTTP APIs
# ─────────────────────────────────────

module "api_gateway" {
  source = "./modules/api-gateway"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 18. EventBridge — Event Bus
# ─────────────────────────────────────

module "eventbridge" {
  source = "./modules/eventbridge"

  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 19. Route53 — DNS
# ─────────────────────────────────────

module "route53" {
  source = "./modules/route53"

  domain_name  = var.domain_name
  environment  = var.environment
  project_name = var.project_name
}

# ─────────────────────────────────────
# 20. CloudFront — CDN
# ─────────────────────────────────────

module "cloudfront" {
  source = "./modules/cloudfront"

  environment  = var.environment
  project_name = var.project_name
}
