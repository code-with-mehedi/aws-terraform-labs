# AWS Terraform Labs

Hands-on, progressive labs for learning **AWS infrastructure as code with Terraform** — from a basic VPC to a full production-grade, multi-tier, containerized platform.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured (`aws configure`)
- An AWS account (⚠️ some labs create billable resources — always `terraform destroy` when done)

## Lab Roadmap

| #  | Lab | Topics |
|----|-----|--------|
| 00 | [bootstrap](00-bootstrap) | Provider, remote backend (S3 + DynamoDB), versions |
| 01 | [vpc-basics](01-vpc-basics) | VPC, subnets, route tables, internet gateway |
| 02 | [vpc-production](02-vpc-production) | Public/private/isolated subnets, NAT gateway, NACLs |
| 03 | [security-groups](03-security-groups) | ALB, web, app, DB & bastion SGs |
| 04 | [ec2](04-ec2) | AMI lookup, key pair, EBS, Elastic IP, user data |
| 05 | [ec2-web-server](05-ec2-web-server) | Nginx web server on EC2 |
| 06 | [alb](06-alb) | Application Load Balancer, target groups, listeners |
| 07 | [multi-tier](07-multi-tier) | Modular network / LB / web / app / DB tiers |
| 08 | [auto-scaling](08-auto-scaling) | Launch templates, ASG, scaling policies |
| 09 | [rds](09-rds) | RDS, subnet & parameter groups |
| 10 | [s3](10-s3) | Buckets, encryption, versioning, lifecycle, policies |
| 11 | [iam](11-iam) | Users, roles, policies, instance profiles |
| 12 | [route53](12-route53) | Hosted zones, records, health checks |
| 13 | [cloudfront](13-cloudfront) | Distributions, origins, cache policies |
| 14 | [cloudwatch](14-cloudwatch) | Logs, alarms, dashboards |
| 15 | [ecs](15-ecs) | ECS on EC2: cluster, tasks, services, autoscaling |
| 16 | [ecs-fargate](16-ecs-fargate) | Serverless containers with Fargate |
| 17 | [ecr](17-ecr) | Container registry, lifecycle, permissions |
| 18 | [eks](18-eks) | EKS cluster, node groups, IAM |
| 19 | [eks-production](19-eks-production) | ALB controller, autoscaling, monitoring |
| 20 | [lambda](20-lambda) | Lambda functions, IAM, API Gateway trigger |
| 21 | [api-gateway](21-api-gateway) | APIs, routes, stages, authorizers |
| 22 | [sqs-sns](22-sqs-sns) | Queues, topics, subscriptions, Lambda consumer |
| 23 | [eventbridge](23-eventbridge) | Event buses, rules, targets |
| 24 | [elasticache](24-elasticache) | Redis cluster |
| 25 | [secrets](25-secrets) | Secrets Manager, KMS |
| 26 | [monitoring](26-monitoring) | CloudWatch + SNS alerting |
| 27 | [high-availability](27-high-availability) | Multi-AZ ASG, ALB, RDS |
| 28 | [disaster-recovery](28-disaster-recovery) | AWS Backup, S3 replication, RDS backups |
| 29 | [final-project](29-final-project) | End-to-end production platform |

## Usage

```bash
cd 01-vpc-basics
terraform init
terraform fmt && terraform validate
terraform plan
terraform apply
terraform destroy   # clean up to avoid charges
```

## Repository Structure

Each numbered folder is a self-contained lab. Labs build on concepts from previous ones, so work through them in order.

## License

MIT
