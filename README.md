# AWS Terraform Labs

Production-grade, **module-based** AWS infrastructure as code with Terraform — a multi-tier architecture with per-environment configurations.

## Architecture

```
aws-terraform-labs/
├── versions.tf                    # Terraform + provider version pins
├── providers.tf                   # AWS provider, default tags
├── backend.tf                     # S3 remote state
├── variables.tf                   # Root-level variables
├── main.tf                        # Orchestrator — calls all modules
├── outputs.tf                     # Infrastructure endpoints
│
├── modules/                       # Reusable, self-contained modules
│   ├── vpc/                       # VPC, subnets, NAT, route tables
│   ├── security-groups/           # ALB, web, app, DB, bastion SGs
│   ├── ec2/                       # Instances, AMI, key pairs, EBS
│   ├── alb/                       # Load balancer, target groups, listeners
│   ├── auto-scaling/              # Launch template, ASG, scaling policies
│   ├── rds/                       # RDS, subnet groups, parameter groups
│   ├── s3/                        # Buckets, encryption, lifecycle
│   ├── iam/                       # Roles, policies, instance profiles
│   ├── route53/                   # Hosted zones, records, health checks
│   ├── cloudfront/                # Distributions, origins, cache policies
│   ├── cloudwatch/                # Logs, alarms, dashboards
│   ├── ecs/                       # Cluster, task definitions, services
│   ├── ecr/                       # Container registry, lifecycle
│   ├── eks/                       # EKS cluster, node groups
│   ├── lambda/                    # Functions, API Gateway trigger
│   ├── api-gateway/               # REST/HTTP APIs, routes, stages
│   ├── sqs/                       # Message queues
│   ├── sns/                       # Topics, subscriptions, alerting
│   ├── eventbridge/               # Event buses, rules, targets
│   ├── elasticache/               # Redis cluster
│   ├── secrets/                   # Secrets Manager, KMS
│   └── tfstate-backend/           # S3 state bucket (bootstrap)
│
└── environments/                  # Per-environment variable overrides
    ├── dev/terraform.tfvars       # 2 AZs, t3.micro, cost-optimized
    ├── stg/terraform.tfvars       # 3 AZs, t3.small, mirrors prod
    └── prod/terraform.tfvars      # 3 AZs, t3.medium, HA-ready
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured (`aws configure`)
- An AWS account (⚠️ always `terraform destroy` when done to avoid charges)

## Usage

```bash
# Initialize
terraform init

# Deploy to dev
terraform plan  -var-file="environments/dev/terraform.tfvars"
terraform apply -var-file="environments/dev/terraform.tfvars"

# Deploy to staging
terraform apply -var-file="environments/stg/terraform.tfvars"

# Deploy to production
terraform apply -var-file="environments/prod/terraform.tfvars"

# Destroy
terraform destroy -var-file="environments/dev/terraform.tfvars"
```

## Module Pattern

Every module under `modules/` follows the same structure:

```
modules/<service>/
├── main.tf          # Resource definitions
├── variables.tf     # Input variables
└── outputs.tf       # Output values
```

Modules are called from the root `main.tf` and wired together through input/output dependencies.

## Environment Strategy

| Environment | VPC CIDR | AZs | Instance Size | Purpose |
|---|---|---|---|---|
| **dev** | `10.0.0.0/16` | 2 | `t3.micro` | Development & testing |
| **stg** | `10.1.0.0/16` | 3 | `t3.small` | Pre-production validation |
| **prod** | `10.2.0.0/16` | 3 | `t3.medium` | Production workloads |

## License

MIT
